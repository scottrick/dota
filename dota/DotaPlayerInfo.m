//
//  DotaPlayerInfo.m
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "DotaPlayerInfo.h"

#import "def.h"
#import "SteamPlayerInfo.h"

@implementation DotaPlayerInfo

- (id) initWithDotaId:(int)newId
{
    self = [super init];
    
    if (self)
    {
        _steamInfo = [[SteamPlayerInfo alloc] initWithSteamId:[DotaPlayerInfo steamAccountIdFromDotaId:newId]];
    }
    
    return self;
}

- (id) initWithSteamInfo:(SteamPlayerInfo *)steamInfo
{
    self = [super init];
    
    if (self)
    {
        _steamInfo = steamInfo;
    }
    
    return self;
}

+ (int) dotaAccountIdFromSteamId:(int64_t)steamId
{
    return steamId & 0x00000000ffffffff;
}

+ (int64_t) steamAccountIdFromDotaId:(int)dotaId
{
    int64_t steamId = STEAM_ACCOUNT_HIGH_PART + (int64_t)dotaId;
    return steamId;
}

- (int) dotaId
{
    return [DotaPlayerInfo dotaAccountIdFromSteamId:self.steamInfo.steamId];
}

@end
