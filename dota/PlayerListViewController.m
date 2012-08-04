//
//  PlayerListViewController.m
//  dota
//
//  Created by Scott Atkins on 8/3/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#import "PlayerListViewController.h"

#import "def.h"
#import "DotaPlayerInfo.h"
#import "Utility.h"

@interface PlayerListViewController ()

@property (nonatomic, strong) NSArray *players;

@end

@implementation PlayerListViewController

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {

    }
    
    return self;
}

- (void) testStuff
{
    NSString *nameString = [Utility urlencode:@"Dr. Zaius"];
    NSString *urlString = [NSString stringWithFormat:DOTA_MATCH_PLAYER_REQUEST_STRING, STEAM_DEV_KEY, nameString];
//    NSString *urlString = [NSString stringWithFormat:DOTA_MATCH_REQUEST_STRING, STEAM_DEV_KEY];
    NSURL *url = [NSURL URLWithString:urlString];

    printf("%s\n", url.description.UTF8String);
    
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

- (NSArray *) createPlayerList
{
    NSMutableArray *newPlayers = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++)
    {
        [newPlayers addObject:[[DotaPlayerInfo alloc] init]];
    }
    
    return newPlayers;
}

- (NSString *) title
{
    return @"Dota2 Players";
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self testStuff];
    
    self.players = [self createPlayerList];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
