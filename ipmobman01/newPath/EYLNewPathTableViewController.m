//
//  EYLNewPathTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 13/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EYLNewPathTableViewController.h"

@interface EYLNewPathTableViewController ()

@end

@implementation EYLNewPathTableViewController
@synthesize fromLabel;
@synthesize fromText;
@synthesize toLabel;
@synthesize toText;
@synthesize timeLabel;
@synthesize goButton;
@synthesize departureSwitch;
@synthesize departureLabel;

@synthesize when;
/*
@synthesize from;
@synthesize to;
@synthesize when;
@synthesize isDeparture;
*/
@synthesize navControllerDelegate;

NSString *dep;
NSString *arr;

NSString *fromPoint;
NSString *toPoint;

NSDateFormatter *timeFormatter;


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
    
    LogInfo(@"--LOAD");
    
    //#INFO needed when coming from stop selection
    [self.navigationItem setHidesBackButton:YES];
    
    fromLabel.text = NSLocalizedString(@"From:", @"from");
    fromText.placeholder = NSLocalizedString(@"Current location", @"from");
    toLabel.text = NSLocalizedString(@"To:", @"to");
    toText.placeholder = NSLocalizedString(@"City center", @"city center");
    goButton.titleLabel.text = NSLocalizedString(@"GO!", @"go");
    
    dep = NSLocalizedString(@"Departure", "Departure");
    arr = NSLocalizedString(@"Arrival", "Arrival");
    
    fromPoint = NSLocalizedString(@"Start point", "Start point");
    toPoint = NSLocalizedString(@"End point", "End point");
    
    [self switchDeparureLabel:true];
    
    self.title = NSLocalizedString(@"New path", @"new path");
    
    timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"dd-MM-YYYY HH:mm";
    
    when = [NSDate date];
    
    self.timeLabel.text = NSLocalizedString(@"Now", @"Now");
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetImage:)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
    
    navControllerDelegate = [[EYLnavigationControllerDelegate alloc] init];
    
    self.navigationController.delegate = navControllerDelegate;
}

- (void)viewDidUnload
{
    [self setDepartureSwitch:nil];
    [self setDepartureLabel:nil];
    [self setFromLabel:nil];
    [self setFromText:nil];
    [self setToLabel:nil];
    [self setToText:nil];
    [self setGoButton:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) showData{
    LogDebug(@"\nFROM: %@\nTO: %@\nWHEN: %@\nisDeparture: %@",fromText.text,toText.text, [timeFormatter stringFromDate: when], departureLabel.text);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController *cvc = (UIViewController *)[segue destinationViewController];
    
    if([[segue identifier] isEqualToString:@"departureSegue"]){
       
        cvc.title = departureLabel.text;
              
        if ([cvc isKindOfClass:[EYLPathDateTimeViewController class]])
        {
            EYLPathDateTimeViewController* pathDateTimeVc = (EYLPathDateTimeViewController *)cvc;
            pathDateTimeVc.delegate = self;
        }
    }
    
    if([[segue identifier] isEqualToString:@"fromPathSegue"]){
        EYLSelectPointTableViewController* dest = (EYLSelectPointTableViewController*)cvc;
        dest.title = fromPoint;
        dest.isStart = true;
    }
    
    if([[segue identifier] isEqualToString:@"toPathSegue"]){
        EYLSelectPointTableViewController* dest = (EYLSelectPointTableViewController*)cvc;
        dest.title = toPoint;
        dest.isStart = false;
    }
}

// used to close keyboard when pushing anywhere
- (void)resetImage:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

#pragma mark - dateTimeProtocol implementation

- (void)setDate:(NSDate *)date{
    self.when = date;
    
    self.timeLabel.text = [timeFormatter stringFromDate: when];
}

- (IBAction)buttonPressed:(id)sender {
    LogDebug(@"push");
}

- (IBAction)textFieldDoneEditing:(id)sender { 
    [sender resignFirstResponder];
}


- (IBAction)backgroundTap:(id)sender { 
    [self.view endEditing:YES];
}
 

- (void)switchDeparureLabel:(BOOL)isDep{
    if (isDep) {
        departureLabel.text = dep;
    }else {
        departureLabel.text = arr;
    }
}

- (IBAction)departureSwitchChanged:(id)sender {
    UISwitch *depSwitch = (UISwitch*)sender;
    [self switchDeparureLabel:depSwitch.isOn];
}

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
