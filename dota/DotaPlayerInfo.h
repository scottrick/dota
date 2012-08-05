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

@property (nonatomic, strong) SteamPlayerInfo *steamInfo;
@property (nonatomic) int dotaId;

- (id) initWithDotaId:(int)newId;

@end
