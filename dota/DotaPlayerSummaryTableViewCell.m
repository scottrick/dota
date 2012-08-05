//
//  DotaPlayerSummaryTableViewCell.m
//  dota
//
//  Created by Scott Atkins on 8/5/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "DotaPlayerSummaryTableViewCell.h"

#import "DotaPlayerInfo.h"
#import "SteamPlayerInfo.h"

@implementation DotaPlayerSummaryTableViewCell

- (id) initWithDotaPlayerInfo:(DotaPlayerInfo *)info
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DOTA_PLAYER_SUMMARY_REUSE_IDENTIFIER];

    if (self)
    {
        self.dotaInfo = info;
    }
    
    return self;
}

- (void) setDotaInfo:(DotaPlayerInfo *)dotaInfo
{
    [_dotaInfo.steamInfo removeSteamInfoChangedListener:self];
    
    _dotaInfo = dotaInfo;
    
    [_dotaInfo.steamInfo addSteamInfoChangedListener:self];

    [self updateViewWithInfo];
}

- (void) updateViewWithInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textLabel.text = self.dotaInfo.steamInfo.name;
        self.imageView.image = self.dotaInfo.steamInfo.avatarFull;
        [self layoutSubviews];
    });
}

- (void) steamPlayerInfoChanged:(SteamPlayerInfo *)steamInfo
{
    [self updateViewWithInfo];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
