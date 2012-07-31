//
//  TestViewController.m
//  dota
//
//  Created by Scott Atkins on 7/31/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "TestViewController.h"

#import "def.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {

    }
    
    return self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *) title
{
    return DOTA_APP_MAIN_TITLE;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
}

@end
