//
//  EYLrouteOption.m
//  ipmobman01
//
//  Created by Alex Zabeo on 24/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLrouteOption.h"

@implementation EYLrouteOption

@synthesize startTime;
@synthesize endTime;
@synthesize duration;
@synthesize steps;
@synthesize distance;

-(EYLrouteStep*)getStepAtIndex:(int)position{
    return ((EYLrouteStep*)[steps objectAtIndex:position]);
}
-(NSString*)getUrlpart{
    NSString* result = @"";
    NSString* result1 = @"";
    NSString* end = @"";
    for (EYLrouteStep* step in steps) {
        result = [[result stringByAppendingString:[step getUrlpart]] stringByAppendingString:urlSeparator];
        result1 = [[result1 stringByAppendingString:@"&1="] stringByAppendingString:step.points];
        end = step.endLonLat;
    }
    result = [result substringToIndex:[result length]-1];
    return [[[[@"?0=" stringByAppendingString: result ] stringByAppendingString:result1] stringByAppendingString:@"&2="] stringByAppendingString:end];
}

@end
