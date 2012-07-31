//
//  AppDelegate.h
//  dota
//
//  Created by Scott Atkins on 7/31/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TestViewController *testController;

@end
