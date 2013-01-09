//
//  EYLPathDateTimeViewController.h
//  ipmobman01
//
//  Created by Alex Zabeo on 18/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dateTimeProtocol

- (void)setDate:(NSDate *)date;

@end

@interface EYLPathDateTimeViewController : UIViewController

@property (nonatomic, weak) id<dateTimeProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *pathDatePicker;

@end
