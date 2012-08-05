//
//  DotaPlayerViewController.m
//  dota
//
//  Created by Scott Atkins on 8/5/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "DotaPlayerViewController.h"

#import "DotaPlayerInfo.h"

@interface DotaPlayerViewController ()

@end

@implementation DotaPlayerViewController

- (id) initWithDotaPlayerInfo:(DotaPlayerInfo *)info
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        _dotaInfo = info;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self updateViews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *) title
{
    return self.dotaInfo.steamInfo.name;
}

- (void) steamPlayerInfoChanged:(SteamPlayerInfo *)steamInfo
{
    [self updateViews];
}

- (void) updateViews
{
    self.nameLabelView.text = self.dotaInfo.steamInfo.name;
    [self.avatarImageView setImage:self.dotaInfo.steamInfo.avatarFull];
    self.statusLabelView.text = self.dotaInfo.steamInfo.status;
}

@end
