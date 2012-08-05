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
#import "DotaPlayerSummaryTableViewCell.h"
#import "SteamPlayerInfo.h"
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
    NSString *nameString = [Utility urlencode:@"Lyle Lanley"];
    NSString *urlString = [NSString stringWithFormat:DOTA_MATCH_PLAYER_SEARCH_REQUEST_STRING, STEAM_DEV_KEY, nameString];
    NSURL *url = [NSURL URLWithString:urlString];

    printf("%s\n", url.description.UTF8String);
    
    //do this stuff in the background, so we don't lock up the phone
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
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

- (void) addDebugDotaInfos
{
    NSMutableArray *newPlayers = [NSMutableArray array];
    
    //add test players
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:60170504]]; //Dr. Zaius
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:79749932]]; //Swedish Fish
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:20617955]]; //fatty
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:40110991]]; //FAT_LENNY
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:40452777]]; //Bluth
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:93502328]]; //TunaWater
    [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:59469598]]; //Lyle Lanley

    self.players = newPlayers;
    
    [self savePlayerList];
}

- (void) loadPlayerList
{
    NSArray *playerDotaIds = [NSMutableArray arrayWithContentsOfFile:[PlayerListViewController playerSaveFileString]];
    NSMutableArray *newPlayers = [NSMutableArray array];
    
    for (NSString *newId in playerDotaIds)
    {
        [newPlayers addObject:[[DotaPlayerInfo alloc] initWithDotaId:newId.intValue]];
    }
    
    self.players = newPlayers;
}

+ (NSString *) playerSaveFileString
{
    //make the path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"favorite_players"];
    return fileName;
}

- (void) savePlayerList
{
    //save the LIST
    NSMutableArray *playerDotaIds = [NSMutableArray array];
    
    for (DotaPlayerInfo *info in self.players)
    {
        [playerDotaIds addObject:[NSNumber numberWithInt:info.dotaId]];
    }
    
    if (![playerDotaIds writeToFile:[PlayerListViewController playerSaveFileString] atomically:YES])
    { //error saving
        NSLog(@"Error saving player id list");
    }
}

- (NSString *) title
{
    return @"Dota2 Players";
}

- (void) viewDidLoad
{
    [super viewDidLoad];
 
    [self loadPlayerList];
    
//    [self addDebugDotaInfos];
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, 44.0f)];
    [titleLabel setText:@"SEARCH GOES HERE"];
    [titleLabel setBackgroundColor:[UIColor orangeColor]];
    [titleLabel setTextColor:[UIColor purpleColor]];
    return titleLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"PLAYER_CELL";
    DotaPlayerSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DOTA_PLAYER_SUMMARY_REUSE_IDENTIFIER];
    
    if (!cell)
    {
        cell = [[DotaPlayerSummaryTableViewCell alloc] initWithDotaPlayerInfo:[self.players objectAtIndex:indexPath.row]];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
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
