//
//  SteamPlayerInfo.m
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "SteamPlayerInfo.h"

@implementation SteamPlayerInfo

- (id) initWithSteamId:(int64_t)newId
{
    self = [super init];
    
    if (self)
    {
        _steamId = newId;
    }
    
    return self;
}

@end
