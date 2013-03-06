//
//  Constants.h
//  ipmobman01
//
//  Created by Alex Zabeo on 18/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

//#import <Foundation/Foundation.h>

#define dStartLat @"45.088127"
#define dStartLon @"7.651534"
#define dEndLat @"45.066974"
#define dEndLon @"7.680416"

#define urlSeparator @"|"
//#define baseUrl @"http://localhost/PhpProject2/Services"
#define baseUrl @"http://ipmobman.comze.com/Services"


#define stopListServiceUrl (baseUrl @"/stopsList.php")
#define pathMapSericeUrl (baseUrl @"/overlayMap.html")
#define stopMapServiceUrl (baseUrl @"/stopsMap.php")

#define dDistanceFromStops 2
#define dNumberOfStops 10

#define dDateStyle NSDateFormatterShortStyle
#define dTimeStyle NSDateFormatterShortStyle

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

extern NSString * const dAgid;


