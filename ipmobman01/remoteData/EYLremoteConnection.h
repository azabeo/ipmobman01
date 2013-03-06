//
//  EYLremoteConnection.h
//  ipmobman01
//
//  Created by Alex Zabeo on 03/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logging.h"
#import "Constants.h"

@protocol remoteConnectionProtocol

@optional
- (void)setDataArray:(NSArray *)dArray;
- (void)setDataDictionary:(NSDictionary *)dDictionary;

@end

@interface EYLremoteConnection : NSObject

@property (nonatomic, weak) id<remoteConnectionProtocol> delegate;

- (BOOL)connectToUrl:(NSString*)url withPostString:(NSString*) postString;

- (void)getStopsByDistanceWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid Limit:(int)lim isMetric:(BOOL)ism;

-(void)getTripOptionsWithOrigin:(NSString*)origin Destination:(NSString*)destination IsDeparture:(BOOL)isDeparture When:(NSString*)when Language:(NSString*)language IsMetric:(BOOL)isMetric;

+ (NSString*)getStopsPostStringWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid Limit:(int)lim isMetric:(BOOL)ism;

@end
