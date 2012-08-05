//
//  SteamPlayerInfo.h
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SteamPlayerInfo;

@protocol SteamPlayerInfoChangedListener <NSObject>

- (void) steamPlayerInfoChanged:(SteamPlayerInfo *)steamInfo;

@end


@interface SteamPlayerInfo : NSObject

@property (nonatomic, strong, readonly) NSDictionary *data; //json steam data
@property (nonatomic, strong) UIImage *avatarFull;
@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) int64_t steamId;

- (id) initWithSteamId:(int64_t)newId;

- (void) addSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener;
- (void) removeSteamInfoChangedListener:(id<SteamPlayerInfoChangedListener>)listener;

@end



