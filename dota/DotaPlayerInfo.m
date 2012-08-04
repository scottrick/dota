//
//  DotaPlayerInfo.m
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "DotaPlayerInfo.h"

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

@end
