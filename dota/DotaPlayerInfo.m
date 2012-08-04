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
        
        [self setDotaId:60170504]; //test!
    }
    
    return self;
}

- (void) setDotaId:(int)newId
{
    int64_t newSteamId = STEAM_ACCOUNT_HIGH_PART + (int64_t)newId;
    self.steamInfo.steamId = newSteamId;
}

- (int) getDotaId
{
    return self.steamInfo.steamId & 0x00000000ffffffff;
}

@end
