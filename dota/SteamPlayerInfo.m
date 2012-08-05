//
//  SteamPlayerInfo.m
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "SteamPlayerInfo.h"

#import "def.h"
#import "Utility.h"

#define NAME_KEY @"personaname"
#define AVATAR_FULL_KEY @"avatarfull"
#define LAST_LOGGED_ON_KEY @"lastlogoff"
#define PERSONA_STATE_KEY @"personastate"

#define SECONDS_IN_A_MINUTE 60
#define SECONDS_IN_AN_HOUR (60 * 60)
#define SECONDS_IN_A_DAY (60 * 60 * 24)

@interface SteamPlayerInfo ()

@property (nonatomic, strong) NSMutableArray *listeners;

@end

@implementation SteamPlayerInfo

- (id) initWithSteamId:(int64_t)newId
{
    self = [super init];
    
    if (self)
    {
        self.listeners = [NSMutableArray mutableArrayUsingWeakReferences];
        
        _steamId = newId;
        [self updateData];
    }
    
    return self;
}

- (void) addSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener
{
    if (![_listeners containsObject:listener])
    {
        [_listeners addObject:listener];
    }
}

- (void) removeSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener
{
    [_listeners removeObject:listener];
}

- (void) notifyListeners
{
    for (id<SteamPlayerInfoChangedListener> listener in _listeners)
    {
        [listener steamPlayerInfoChanged:self];
    }
}

- (void) updateData
{
    NSString *urlString = [NSString stringWithFormat:STEAM_PLAYER_SUMMARY_REQUEST_STRING, STEAM_DEV_KEY, _steamId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //do this stuff in the background, so we don't lock up the phone
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        
        //parse JSON
        if (data)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//            printf("%s\n", json.description.UTF8String); //print raw json response
            
            NSDictionary *response = [json objectForKey:@"response"];
            NSArray *players = [response objectForKey:@"players"];
            
            if (players.count == 1)
            {
                _data = [players objectAtIndex:0];
            }
            
            printf("%s\n", _data.description.UTF8String);
    
            [self notifyListeners];
        }
        else
        {
            //error getting the data?!?
            printf("ERROR:  %s\n", error.description.UTF8String);
        }
    });
}

- (UIImage *) avatarFull
{
    if (_avatarFull)
    {
        return _avatarFull;
    }
    
    if (_data)
    {
        //we don't have the avatar, so lets get it
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString *imageUrl = [_data objectForKey:AVATAR_FULL_KEY];
            NSURL *url = [NSURL URLWithString:imageUrl];
            NSError *error = nil;

            NSData *imageData = [NSData dataWithContentsOfURL:url options:0 error:&error];
            
            if (imageData)
            {
                self.avatarFull = [UIImage imageWithData:imageData];
                [self notifyListeners];
            }
            else
            { //error?
                printf("error fetching avatarFull\n%s\n", error.description.UTF8String);
            }
        });
    }
    
    return [UIImage imageNamed:@"recipe.png"];
}

- (NSString *) name
{
    if (_data)
    {
        return [_data objectForKey:NAME_KEY];
    }
    else
    {
        return [NSString stringWithFormat:@"%lld", _steamId];
    }
}

- (NSString *) status
{
    switch (self.state)
    {
        case SteamPlayerState_Offline:
        {
            NSTimeInterval timeSinceLoggedIn = [[NSDate date] timeIntervalSince1970] - [[_data objectForKey:LAST_LOGGED_ON_KEY] doubleValue];
            
            int time = (int)timeSinceLoggedIn;
            int days = time / SECONDS_IN_A_DAY;
            time -= (days * SECONDS_IN_A_DAY);
            
            int hours = time / SECONDS_IN_AN_HOUR;
            time -= (hours * SECONDS_IN_AN_HOUR);
            
            int minutes = time / SECONDS_IN_A_MINUTE;

            if (days)
            {
                return [NSString stringWithFormat:@"Last logged in %d days, %d hours and %d minutes ago.", days, hours, minutes];
            }
            else if (hours)
            {
                return [NSString stringWithFormat:@"Last logged in %d hours and %d minutes ago.", hours, minutes];
            }
            else
            {
                return [NSString stringWithFormat:@"Last logged in %d minutes ago.", minutes];
            }
        }
            break;
            
        case SteamPlayerState_Away:
            return @"Online (Away)";
        case SteamPlayerState_Busy:
            return @"Online (Busy)";
        case SteamPlayerState_LookingToPlay:
            return @"Online (Looking To Play)";
        case SteamPlayerState_LookingToTrade:
            return @"Online (Looking To Trae)";
        case SteamPlayerState_Online:
            return @"Online";
        case SteamPlayerState_Snooze:
            return @"Online (Snooze)";
            
        case SteamPlayerState_Unknown:
        default:
            return nil;
    }
}

- (enum SteamPlayerState) state
{
    if (_data)
    {
        return (enum SteamPlayerState) [[_data objectForKey:PERSONA_STATE_KEY] intValue];
    }
    else
    {
        return SteamPlayerState_Unknown;
    }
}

@end
