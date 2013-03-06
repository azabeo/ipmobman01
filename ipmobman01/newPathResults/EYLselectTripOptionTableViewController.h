//
//  EYLselectTripOptionTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYLnavigationControllerDelegate.h"
#import "EYLremoteConnection.h"
#import "EYLtripResultsParser.h"
#import "EYLutilities.h"
#import "EYLrouteOption.h"
#import "Logging.h"

@interface EYLselectTripOptionTableViewController : UITableViewController <remoteConnectionProtocol, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *optionsActivityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;

//@property (strong, nonatomic) NSDictionary* optionsDictionary;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertViewCancel:(UIAlertView *)alertView;

@end
