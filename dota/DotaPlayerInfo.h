//
//  DotaPlayerInfo.h
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SteamPlayerInfo;

@interface DotaPlayerInfo : NSObject

@property (nonatomic, strong, readonly) SteamPlayerInfo *steamInfo;
@property (nonatomic, readonly) int dotaId;

- (id) initWithDotaId:(int)newId;
- (id) initWithSteamInfo:(SteamPlayerInfo *)steamInfo;

+ (int) dotaAccountIdFromSteamId:(int64_t)steamId;
+ (int64_t) steamAccountIdFromDotaId:(int)dotaId;

@end
