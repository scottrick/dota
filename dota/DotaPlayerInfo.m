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

- (id) init
{
    self = [super init];
    
    if (self)
    {
        self.steamInfo = [[SteamPlayerInfo alloc] init];
    }
    
    return self;
}

- (id) initWithDotaId:(int)newId
{
    self = [super init];
    
    if (self)
    {
        self.steamInfo = [[SteamPlayerInfo alloc] init];
        self.dotaId = newId;
    }
    
    return self;
}

- (void) setDotaId:(int)newId
{
    int64_t newSteamId = STEAM_ACCOUNT_HIGH_PART + (int64_t)newId;
    
//    printf("setting dotaId to  %d,  %lld\n", newId, newSteamId);
    self.steamInfo.steamId = newSteamId;
}

- (int) dotaId
{
    return self.steamInfo.steamId & 0x00000000ffffffff;
}

@end
