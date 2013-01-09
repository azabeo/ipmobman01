//
//  EYLselectTripOptionTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLselectTripOptionTableViewController.h"

@interface EYLselectTripOptionTableViewController ()

@property (strong, nonatomic) NSArray* options;
@property (strong, nonatomic) NSString* from;
@property (strong, nonatomic) NSString* to;
@property (strong, nonatomic) NSString* when;
@property (strong, nonatomic) NSString* departure;

@end

@implementation EYLselectTripOptionTableViewController

@synthesize options;
@synthesize from;
@synthesize to;
@synthesize when;
@synthesize departure;

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
    
    self.options = [NSArray arrayWithObjects:@"ciao", @"secondo", @"terxo", nil];
    self.from = @"casa mia";
    self.to = @"lavoro";
    self.when = @"adesso";
    self.departure = @"Departure";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return nil;
    }else {
        //#TODO aggiustare per multilingua
        return @"Options";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else {
        return [options count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    //#TODO adjust for multilanguage

    if (indexPath.section==0) {
        CellIdentifier = @"recapCell";
    }else {
        CellIdentifier = @"optionCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (indexPath.section==0) {
        ((UILabel *)[cell viewWithTag:1]).text = @"From:";
        ((UILabel *)[cell viewWithTag:2]).text = @"To:";
        ((UILabel *)[cell viewWithTag:3]).text = self.departure;
        ((UILabel *)[cell viewWithTag:4]).text = self.from;
        ((UILabel *)[cell viewWithTag:5]).text = self.to;
        ((UILabel *)[cell viewWithTag:6]).text = self.when;
    }else {
        ((UILabel *)[cell viewWithTag:1]).text = [options objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 110;
    } else {
        return t.rowHeight;
        LogDebug(@"%@",t.rowHeight);
    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
