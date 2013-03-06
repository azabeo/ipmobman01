//
//  EYLrouteStep.m
//  ipmobman01
//
//  Created by Alex Zabeo on 31/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLrouteStep.h"

@implementation EYLrouteStep

@synthesize description;
@synthesize startLonLat;
@synthesize endLonLat;
@synthesize distance;
@synthesize duration;
@synthesize substeps;
@synthesize travel_mode;
@synthesize transit_details;
@synthesize points;

-(BOOL)isWalk{
    return [travel_mode isEqualToString:@"WALKING"];
}

-(EYLrouteSubStep*)getSubStepAtIndex:(int)position{
    if (substeps) {
        return ((EYLrouteSubStep*)[substeps objectAtIndex:position]);
    }
    return nil;
}

-(NSString*)getUrlpart{
    return [[startLonLat stringByAppendingString:@","]stringByAppendingString:[travel_mode substringToIndex:1]];
}

@end
