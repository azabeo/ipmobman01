//
//  EYLrouteOption.h
//  ipmobman01
//
//  Created by Alex Zabeo on 24/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYLrouteStep.h"
#import "Constants.h"

@interface EYLrouteOption : NSObject

@property (strong, nonatomic) NSString* startTime;
@property (strong, nonatomic) NSString* endTime;
@property (strong, nonatomic) NSString* duration;
@property (strong, nonatomic) NSString* distance;
@property (strong, nonatomic) NSArray* steps;

-(EYLrouteStep*)getStepAtIndex:(int)position;
-(NSString*)getUrlpart;

@end
