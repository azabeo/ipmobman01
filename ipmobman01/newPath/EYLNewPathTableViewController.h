//
//  EYLNewPathTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 13/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYLPathDateTimeViewController.h"
#import "EYLSelectPointTableViewController.h"
#import "EYLnavigationControllerDelegate.h"
#import "Logging.h"

@interface EYLNewPathTableViewController : UITableViewController <dateTimeProtocol>

//@property (strong, nonatomic) NSString *from;
//@property (strong, nonatomic) NSString *to;
@property (strong, nonatomic) NSDate *when;
//@property (nonatomic) BOOL *isDeparture;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UITextField *fromText;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UITextField *toText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *goButton;

@property (weak, nonatomic) IBOutlet UISwitch *departureSwitch;
@property (weak, nonatomic) IBOutlet UILabel *departureLabel;

@property (strong, nonatomic) EYLnavigationControllerDelegate* navControllerDelegate;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (IBAction)departureSwitchChanged:(id)sender;

- (void) showData;

@end
