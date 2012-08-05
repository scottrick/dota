//
//  SteamPlayerInfo.h
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SteamPlayerInfo;

enum SteamPlayerState
{ //  0 - Offline, 1 - Online, 2 - Busy, 3 - Away, 4 - Snooze, 5 - looking to trade, 6 - looking to play
    SteamPlayerState_Offline,
    SteamPlayerState_Online,
    SteamPlayerState_Busy,
    SteamPlayerState_Away,
    SteamPlayerState_Snooze,
    SteamPlayerState_LookingToTrade,
    SteamPlayerState_LookingToPlay,
    SteamPlayerState_Unknown,
};

@protocol SteamPlayerInfoChangedListener <NSObject>

- (void) steamPlayerInfoChanged:(SteamPlayerInfo *)steamInfo;

@end


@interface SteamPlayerInfo : NSObject

@property (nonatomic, strong, readonly) NSDictionary *data; //json steam data
@property (nonatomic, strong) UIImage *avatarFull;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) enum SteamPlayerState state;

@property (nonatomic, readonly) int64_t steamId;

- (id) initWithSteamId:(int64_t)newId;

- (void) addSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener;
- (void) removeSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener;

@end



