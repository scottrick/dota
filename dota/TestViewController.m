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
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", DOTA_MATCH_REQUEST_STRING, STEAM_DEV_KEY];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //do this stuff in the background, so we don't lock up the phone
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        //get our movies
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        
        //parse JSON
        if (data)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            printf("%s\n", json.description.UTF8String);
        
        }
        else
        {
            //error getting the data?!?
            printf("ERROR:  %s\n", error.description.UTF8String);
        }
    });
}

@end
