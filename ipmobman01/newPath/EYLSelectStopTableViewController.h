//
//  EYLSelectStopTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 21/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYLremoteConnection.h"
#import "EYLNewPathTableViewController.h"
#import "EYLnavigationControllerDelegate.h"
#import "Constants.h"
#import "Logging.h"

@interface EYLSelectStopTableViewController : UITableViewController<remoteDataProtocol>

@property (weak, nonatomic) IBOutlet UITableView *stopsTableView;
@property (strong, nonatomic) NSMutableArray* stopsList;

@property (nonatomic) BOOL isStart;

@end
