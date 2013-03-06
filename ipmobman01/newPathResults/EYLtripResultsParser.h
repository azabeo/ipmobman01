//
//  EYLtripResultsParser.h
//  ipmobman01
//
//  Created by Alex Zabeo on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYLrouteOption.h"
#import "EYLrouteStep.h"
#import "EYLrouteTransitDetail.h"
#import "EYLrouteSubStep.h"
#import "EYLutilities.h"
#import "Logging.h"

@interface EYLtripResultsParser : NSObject

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSArray*)getStatus;

-(EYLrouteOption*)getOptionAtPosition:(int)position;
-(int)countOptions;

+(UIImageView*)getImageForTravelMode:(NSString*)mode withFrame:(CGRect)frame;
+(NSString*)getImageNameForCompany:(NSString*)companyName;

@end
