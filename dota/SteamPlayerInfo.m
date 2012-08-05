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

@end
