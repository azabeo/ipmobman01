//
//  EYLtripResultsParser.m
//  ipmobman01
//
//  Created by Alex Zabeo on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

/*
 OK indicates the response contains a valid result.
 NOT_FOUND indicates at least one of the locations specified in the requests's origin, destination, or waypoints could not be geocoded.
 ZERO_RESULTS indicates no route could be found between the origin and destination.
 MAX_WAYPOINTS_EXCEEDED indicates that too many waypointss were provided in the request The maximum allowed waypoints is 8, plus the origin, and destination. ( Google Maps API for Business customers may contain requests with up to 23 waypoints.)
 INVALID_REQUEST indicates that the provided request was invalid. Common causes of this status include an invalid parameter or parameter value.
 OVER_QUERY_LIMIT indicates the service has received too many requests from your application within the allowed time period.
 REQUEST_DENIED indicates that the service denied use of the directions service by your application.
 UNKNOWN_ERROR  indicates a directions request could not be processed due to a server error. The request may succeed if you try again.
 */

#import "EYLtripResultsParser.h"

@implementation EYLtripResultsParser

NSDictionary* dictionary;
NSBundle *bundle;
NSArray* options;

-(int)countOptions{
    return [options count];
}

-(id)initWithDictionary:(NSDictionary*)dict{
    if ([super init]) {
        dictionary = dict;
        //bundle = [NSBundle mainBundle];
    }
    
    NSMutableArray* ops = [NSMutableArray new];
    
    NSDictionary* leg;
    
    for (NSDictionary* route in [dictionary objectForKey:@"routes"]) {
        leg = [[route objectForKey:@"legs"] objectAtIndex:0];
        
        EYLrouteOption* option = [[EYLrouteOption alloc] init];
        
        option.startTime = [[leg objectForKey:@"departure_time"] objectForKey:@"text"];
        option.endTime = [[leg objectForKey:@"arrival_time"] objectForKey:@"text"];
        option.duration = [[leg objectForKey:@"duration"] objectForKey:@"text"];
        option.distance = [[leg objectForKey:@"distance"] objectForKey:@"text"];
        
        NSMutableArray* steps = [[NSMutableArray alloc] init];
        
        for (NSDictionary* stepDic in [leg objectForKey:@"steps"]) {
            
            EYLrouteStep* step = [EYLrouteStep new];
            
            step.distance = [[stepDic objectForKey:@"distance"] objectForKey:@"text"];
            step.duration = [[stepDic objectForKey:@"duration"] objectForKey:@"text"];
            step.description = [stepDic objectForKey:@"html_instructions"];
            step.startLonLat = [NSString stringWithFormat:@"%@",[[stepDic objectForKey:@"start_location"] objectForKey:@"lat"]];
            step.startLonLat = [[step.startLonLat stringByAppendingString:@","]  stringByAppendingString:[NSString stringWithFormat:@"%@", [[stepDic objectForKey:@"start_location"] objectForKey:@"lng"]]];
            step.endLonLat = [NSString stringWithFormat:@"%@",[[stepDic objectForKey:@"end_location"] objectForKey:@"lat"]];
            step.endLonLat = [[step.endLonLat stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%@",[[stepDic objectForKey:@"end_location"] objectForKey:@"lng"]]];
            step.travel_mode = @"WALKING";
            step.points = [[stepDic objectForKey:@"polyline"] objectForKey:@"points"];
            step.substeps = Nil;
            step.transit_details = Nil;
            
            if ([stepDic objectForKey:@"transit_details"]) {
                
                NSDictionary* td = [stepDic objectForKey:@"transit_details"];
                step.transit_details = [EYLrouteTransitDetail new];
                
                step.transit_details.start_name = [[td objectForKey:@"departure_stop"] objectForKey:@"name"];
                step.transit_details.start_time = [[td objectForKey:@"departure_time"] objectForKey:@"text"];
                step.transit_details.end_name = [[td objectForKey:@"arrival_stop"] objectForKey:@"name"];
                step.transit_details.end_time = [[td objectForKey:@"arrival_time"] objectForKey:@"text"];
                step.transit_details.headsign = [td objectForKey:@"headsign"];
                step.transit_details.num_stops = [NSString stringWithFormat:@"%@",[td objectForKey:@"num_stops"]];                
                step.transit_details.color = [[td objectForKey:@"line"] objectForKey:@"color"];
                step.transit_details.name = [[td objectForKey:@"line"] objectForKey:@"name"];
                step.transit_details.short_name = [[td objectForKey:@"line"] objectForKey:@"short_name"];
                step.transit_details.company_name = [[[[td objectForKey:@"line"] objectForKey:@"agencies"] objectAtIndex:0] objectForKey:@"name"];
                step.transit_details.company_url = [[[[td objectForKey:@"line"] objectForKey:@"agencies"] objectAtIndex:0] objectForKey:@"url"];

                step.travel_mode = [[[[stepDic objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"vehicle"] objectForKey:@"type"];
            }else {
                NSMutableArray* subSteps = [NSMutableArray new];
                EYLrouteSubStep* subStep;
                for (NSDictionary* subStepDic in [stepDic objectForKey:@"steps"]) {
                    subStep = [EYLrouteSubStep new];
                    subStep.distance = [[subStepDic objectForKey:@"distance"] objectForKey:@"text"];
                    subStep.duration = [[subStepDic objectForKey:@"duration"] objectForKey:@"text"];
                    subStep.description = [subStepDic objectForKey:@"html_instructions"];
                    if (subStep.description) {
                        [subSteps addObject:subStep];
                    }
                }
                step.substeps = subSteps;
            }
            
            [steps addObject:step];
            
        }
        option.steps = steps;
        
        [ops addObject:option];
    }
    
    options = ops;
    
    return self;
}

-(NSArray*)getStatus{
    NSString* status = (NSString*)[dictionary objectForKey:@"status"];
    NSArray* result;
    
    if ([status isEqualToString:@"OK"]) {
        result = [[NSArray alloc] initWithObjects:@"1",@"OK",nil];    
    }
    if ([status isEqualToString:@"ZERO_RESULTS"]) {
        result = [[NSArray alloc] initWithObjects:@"0",NSLocalizedString(@"No route could be found between the origin and destination", @"No route could be found between the origin and destination"),nil];    
    }
    if ([status isEqualToString:@"OVER_QUERY_LIMIT"]) {
        result = [[NSArray alloc] initWithObjects:@"0",NSLocalizedString(@"Service cngested try later",@"Service cngested try later"),nil];    
    }
    if ([status isEqualToString:@"MAX_WAYPOINTS_EXCEEDED"] || [status isEqualToString:@"INVALID_REQUEST"] || [status isEqualToString:@"REQUEST_DENIED"]  || [status isEqualToString:@"UNKNOWN_ERROR"]) {
        result = [[NSArray alloc] initWithObjects:@"0",NSLocalizedString(@"Unexpected error, please try again",@"Unexpected error, please try again"),nil];    
    }
    
    return result;
}

-(EYLrouteOption*)getOptionAtPosition:(int)position{
    return [options objectAtIndex:position];
}

+(NSString*)getImageNameForCompany:(NSString*)companyName{
    
    if ([companyName isEqualToString:@"Gruppo Torinese Trasporti"]) {
        return @"gtt.png";
    }
    
    return nil;
}

+(UIImageView*)getImageForTravelMode:(NSString*)mode withFrame:(CGRect)frame{
    NSString* name;
    
    if ([mode isEqualToString:@"WALKING"]) {
        name = @"walk";
    }
    if ([mode isEqualToString:@"BUS"]) {
        name = @"bus";
    }
    if ([mode isEqualToString:@"SUBWAY"]) {
        name = @"it-metro";
    }
    if ([mode isEqualToString:@"TRAM"]) {
        name = @"tram";
    }
    
    return [EYLutilities getPngImageForName:name withFrame:frame];
    
    /*
    UIImageView *imv = [[UIImageView alloc]initWithFrame:frame];
    
    NSURL *plistURL = nil;
    
    if ([mode isEqualToString:@"WALKING"]) {
        plistURL = [bundle URLForResource:@"walk" withExtension:@"png"];
    }
    if ([mode isEqualToString:@"arrow"]) {
        plistURL = [bundle URLForResource:@"arrow" withExtension:@"png"];
    }
    if ([mode isEqualToString:@"BUS"]) {
        plistURL = [bundle URLForResource:@"bus" withExtension:@"png"];
    }
    if ([mode isEqualToString:@"SUBWAY"]) {
        plistURL = [bundle URLForResource:@"it-metro" withExtension:@"png"];
    }
    if ([mode isEqualToString:@"TRAM"]) {
        plistURL = [bundle URLForResource:@"tram" withExtension:@"png"];
    }
    
    imv.image = [UIImage imageWithContentsOfFile:[plistURL path]];
    return imv;
     */
}

@end

