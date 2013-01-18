//
//  EYLnavigationControllerDelegate.h
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logging.h"
#import "Constants.h"

@interface EYLnavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

@property (strong, nonatomic) NSString* latStart;
@property (strong, nonatomic) NSString* lonStart;
@property (strong, nonatomic) NSString* latEnd;
@property (strong, nonatomic) NSString* lonEnd;

@property (strong, nonatomic) NSString* cityName;

@property (strong, nonatomic) NSString* from;
@property (strong, nonatomic) NSString* to;
@property (strong, nonatomic) NSString* when;

@property BOOL isDeparture;
@property BOOL isMetric;

@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* language;

-(void)printMe;

@end
