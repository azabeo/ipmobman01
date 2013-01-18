//
//  EYLNewPathTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 13/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

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
@synthesize locationManager; 
@synthesize startingPoint;
@synthesize locationActivityIndicator;
@synthesize when;
@synthesize navControllerDelegate;
@synthesize language;

NSString *dep;
NSString *arr;

NSString *fromPoint;
NSString *toPoint;

NSDateFormatter *timeFormatter;
NSDateFormatter *fixedDateFormatter;


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
    fromText.placeholder = NSLocalizedString(@"Locating...", @"Locating...");
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
    [timeFormatter setDateStyle:dDateStyle];
    [timeFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    fixedDateFormatter = [[NSDateFormatter alloc]init];
    [fixedDateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    when = [NSDate date];
    
    self.timeLabel.text = NSLocalizedString(@"Now", @"Now");
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetImage:)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
    
    navControllerDelegate = [[EYLnavigationControllerDelegate alloc] init];
    
    self.navigationController.delegate = navControllerDelegate;
    
    /*
    dispatch_async(kBgQueue, ^{
        [self performSelectorOnMainThread:@selector(getLatLon) 
                               withObject:Nil waitUntilDone:YES];
    });
    */
    
    [self getLatLon];
    [self getLanguage];

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
    [self setLocationActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) getLanguage{
    NSLocale *locale = [NSLocale currentLocale]; 
    
    navControllerDelegate.language = [locale objectForKey:NSLocaleLanguageCode];
    navControllerDelegate.country = [locale objectForKey:NSLocaleCountryCode];
    navControllerDelegate.isMetric = [((NSNumber*)[locale objectForKey:NSLocaleUsesMetricSystem]) boolValue];
    
    LogInfo(@"LANGUAGE: %@",[locale displayNameForKey:NSLocaleIdentifier value:[locale localeIdentifier]]); 
}

- (void) getLatLon{
    LogDebug(@"Getting location");
    
    [locationActivityIndicator startAnimating];
    
    self.locationManager = [[CLLocationManager alloc] init]; 
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
    [locationManager startUpdatingLocation];
}

- (NSString*) getCityName:(NSString*)startLatLng{
    //#TODO chiamare geocoding coon lalton
    //#TODO prendere il nome città e nazione
    return @"Torino, Italia";
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if (startingPoint == nil) self.startingPoint = newLocation;
    
    navControllerDelegate.latStart =  [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    navControllerDelegate.lonStart =  [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    navControllerDelegate.cityName = [self getCityName:[[navControllerDelegate.latStart stringByAppendingString:@","] stringByAppendingString:navControllerDelegate.lonStart]];
    
    [locationManager stopUpdatingLocation];
    [locationActivityIndicator stopAnimating];
    
    fromText.placeholder = NSLocalizedString(@"Current location", @"Current location");
    
    //LogDebug(@"LATLON: %@ - %@",navControllerDelegate.latStart, navControllerDelegate.lonStart);
    [navControllerDelegate printMe];
    
    /*
    EYLremoteConnection* connection = [[EYLremoteConnection alloc] init];
    connection.delegate = self;
    [connection getStopsByDistanceWithLat:latitudeString Lon:longitudeString Dist:2 AgencyGlobalId:agid];
     */
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } 
    if (error.code == kCLErrorLocationUnknown) {
        //nothing to do
    } 
    
    LogError(@"Location Error");
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
    
    if([[segue identifier] isEqualToString:@"goSegue"]){
        //EYLselectTripOptionTableViewController* dest = (EYLselectTripOptionTableViewController*)cvc;
        if ([fromText.text length] != 0) {
            navControllerDelegate.from = fromText.text;
        }else {
            navControllerDelegate.from = [[navControllerDelegate.latStart stringByAppendingString:@","]stringByAppendingString:navControllerDelegate.lonStart];
        }
        if ([toText.text length] != 0) {
            navControllerDelegate.to = toText.text;
        }else {
            if ([navControllerDelegate.cityName length] != 0) {
                navControllerDelegate.to = navControllerDelegate.cityName;
            } else {
                navControllerDelegate.to = [[navControllerDelegate.latEnd stringByAppendingString:@","]stringByAppendingString:navControllerDelegate.lonEnd];
            }
        }
        navControllerDelegate.when = [NSString stringWithFormat:@"%i",(int)[when timeIntervalSince1970]] ;
        navControllerDelegate.isDeparture = departureSwitch.on;
        
        LogDebug(@"SEGUE %@",fromText.text);
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
        
    if ([[fixedDateFormatter stringFromDate:when] isEqualToString:[fixedDateFormatter stringFromDate:[NSDate date]]]) {
        [timeFormatter setTimeStyle:NSDateFormatterNoStyle];
    } else {
        [timeFormatter setTimeStyle:dTimeStyle];
    }
    
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
