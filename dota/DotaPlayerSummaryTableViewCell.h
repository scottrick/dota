//
//  DotaPlayerSummaryTableViewCell.h
//  dota
//
//  Created by Scott Atkins on 8/5/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SteamPlayerInfo.h"

#define DOTA_PLAYER_SUMMARY_REUSE_IDENTIFIER @"DotaPlayerSummaryTableViewCell"

@class DotaPlayerInfo;

@interface DotaPlayerSummaryTableViewCell : UITableViewCell<SteamPlayerInfoChangedListener>

@property (nonatomic, strong) DotaPlayerInfo *dotaInfo;

- (id) initWithDotaPlayerInfo:(DotaPlayerInfo *)info;

@end
