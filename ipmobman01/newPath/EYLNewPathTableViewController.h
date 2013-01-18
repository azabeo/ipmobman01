//
//  EYLNewPathTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 13/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EYLPathDateTimeViewController.h"
#import "EYLSelectPointTableViewController.h"
#import "EYLnavigationControllerDelegate.h"
#import "EYLselectTripOptionTableViewController.h"
#import "Logging.h"
//#import "Constants.h"

@interface EYLNewPathTableViewController : UITableViewController <dateTimeProtocol, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *locationActivityIndicator;

//@property (strong, nonatomic) NSDate *when;
//@property (strong, nonatomic) NSString *language;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UITextField *fromText;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UITextField *toText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *goButton;

@property (weak, nonatomic) IBOutlet UISwitch *departureSwitch;
@property (weak, nonatomic) IBOutlet UILabel *departureLabel;

@property (strong, nonatomic) EYLnavigationControllerDelegate* navControllerDelegate;

@property (strong, nonatomic) CLLocationManager *locationManager; 
//@property (strong, nonatomic) CLLocation *startingPoint;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (IBAction)departureSwitchChanged:(id)sender;

@end
