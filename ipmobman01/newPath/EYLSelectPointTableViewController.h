//
//  EYLSelectPointTableViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 21/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYLSelectStopTableViewController.h"

@interface EYLSelectPointTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *selectStopByNameLabel;

@property BOOL isStart;

@end
