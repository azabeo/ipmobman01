//
//  EYLSelectStopTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 21/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EYLSelectStopTableViewController.h"

@interface EYLSelectStopTableViewController ()

@end

@implementation EYLSelectStopTableViewController

@synthesize stopsTableView;
@synthesize stopsList;
@synthesize stopsActivityIndicator;
@synthesize isStart;

NSMutableString* selectedStopName;
EYLNewPathTableViewController* dest = Nil;
EYLnavigationControllerDelegate* nav = Nil;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Select a stop", @"Select a stop");
    
    nav = self.navigationController.delegate;
    
    dispatch_async(kBgQueue, ^{
        [self performSelectorOnMainThread:@selector(getRemoteData) 
                               withObject:Nil waitUntilDone:YES];
    });

}

- (void)viewDidUnload
{
    [self setStopsTableView:nil];
    [self setStopsActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    self.stopsList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - remoteDataProtocol implementation

- (void) getRemoteData{
    LogDebug(@"getStops");
    
    EYLremoteConnection* connection = [[EYLremoteConnection alloc] init];
    connection.delegate = self;
    
    [stopsActivityIndicator startAnimating];
    
    [connection getStopsByDistanceWithLat:(nav.latStart) Lon:(nav.lonStart) Dist:dDistanceFromStops AgencyGlobalId:dAgid Limit:dNumberOfStops isMetric:(nav.isMetric)];
}
 
-(void) setDataArray:(NSArray *)dArray{
    LogDebug(@"ISRECEIVED");
    
    self.stopsList = ((NSMutableArray*)dArray);
    
    [stopsActivityIndicator stopAnimating];
    [stopsTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [stopsList count];
    //return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"stopsCell";
    NSString *stop = [((NSArray*)[self.stopsList objectAtIndex:indexPath.row]) objectAtIndex:1];
    NSString *dist = [((NSArray*)[self.stopsList objectAtIndex:indexPath.row]) objectAtIndex:2];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // Configure the cell...
    ((UILabel *)[cell viewWithTag:1]).text = stop;
    ((UILabel *)[cell viewWithTag:2]).text = dist;
    
    return cell;
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController *cvc = (UIViewController *)[segue destinationViewController];
    
    if([[segue identifier] isEqualToString:@"stopSelectedSegue"]){
        dest = (EYLNewPathTableViewController*)cvc;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        selectedStopName = [((NSArray*)[self.stopsList objectAtIndex:indexPath.row]) objectAtIndex:1];
        
        LogDebug(@"SEGUE -- %@",selectedStopName);
        
        if (isStart) {
            dest.from = selectedStopName;
            //dest.fromText.text = selectedStopName;
        }else {
            dest.to = selectedStopName;
            //dest.toText.text = selectedStopName;
        }
        
        
      
        
    }
}
*/

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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    //selectedStopName = [((NSArray*)[self.stopsList objectAtIndex:indexPath.row]) objectAtIndex:1];
    
    dest = (EYLNewPathTableViewController*)([self.navigationController.viewControllers objectAtIndex:0]);
    
    selectedStopName = [((NSArray*)[self.stopsList objectAtIndex:indexPath.row]) objectAtIndex:1];
    
    if (isStart) {
        dest.fromText.text = selectedStopName;
    }else {
        dest.toText.text = selectedStopName;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
