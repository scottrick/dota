//
//  SteamPlayerInfo.h
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SteamPlayerInfo : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) UIImage *avatar;

@property (nonatomic, readonly) int64_t steamId;

- (id) initWithSteamId:(int64_t)newId;

@end
