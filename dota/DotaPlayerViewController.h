//
//  DotaPlayerViewController.h
//  dota
//
//  Created by Scott Atkins on 8/5/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SteamPlayerInfo.h"

@class DotaPlayerInfo;

@interface DotaPlayerViewController : UIViewController<SteamPlayerInfoChangedListener>

@property (nonatomic, strong, readonly) DotaPlayerInfo *dotaInfo;

@property (nonatomic, strong) IBOutlet UILabel *nameLabelView;
@property (nonatomic, strong) IBOutlet UILabel *statusLabelView;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

- (id) initWithDotaPlayerInfo:(DotaPlayerInfo *)info;

@end
