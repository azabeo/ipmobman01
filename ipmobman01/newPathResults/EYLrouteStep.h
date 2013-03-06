//
//  EYLrouteStep.h
//  ipmobman01
//
//  Created by Alex Zabeo on 31/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYLrouteTransitDetail.h"
#import "EYLrouteSubStep.h"

@interface EYLrouteStep : NSObject

@property (strong, nonatomic) NSString* duration;
@property (strong, nonatomic) NSString* distance;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* startLonLat;
@property (strong, nonatomic) NSString* endLonLat;
@property (strong, nonatomic) NSString* travel_mode;
@property (strong, nonatomic) EYLrouteTransitDetail* transit_details;
@property (strong, nonatomic) NSArray* substeps;
@property (strong, nonatomic) NSString* points;

-(BOOL)isWalk;
-(EYLrouteSubStep*)getSubStepAtIndex:(int)position;
-(NSString*)getUrlpart;

@end
