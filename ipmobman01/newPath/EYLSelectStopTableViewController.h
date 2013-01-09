//
//  EYLSelectStopTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 21/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EYLremoteConnection.h"
#import "EYLNewPathTableViewController.h"
#import "Logging.h"

@interface EYLSelectStopTableViewController : UITableViewController<remoteDataProtocol, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *stopsTableView;
@property (strong, nonatomic) CLLocationManager *locationManager; 
@property (strong, nonatomic) CLLocation *startingPoint;
@property (strong, nonatomic) NSMutableArray* stopsList;

@property (nonatomic) BOOL isStart;

@end
