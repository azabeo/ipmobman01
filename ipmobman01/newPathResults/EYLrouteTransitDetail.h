//
//  EYLrouteTransitDetail.h
//  ipmobman01
//
//  Created by Alex Zabeo on 31/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EYLrouteTransitDetail : NSObject

@property (strong, nonatomic) NSString* start_name;
@property (strong, nonatomic) NSString* end_name;
@property (strong, nonatomic) NSString* start_time;
@property (strong, nonatomic) NSString* end_time;
@property (strong, nonatomic) NSString* headsign;
@property (strong, nonatomic) NSString* num_stops;
@property (strong, nonatomic) NSString* color;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* short_name;
@property (strong, nonatomic) NSString* company_url;
@property (strong, nonatomic) NSString* company_name;

@end
