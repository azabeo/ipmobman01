//
//  EYLremoteConnection.h
//  ipmobman01
//
//  Created by Alex Zabeo on 03/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logging.h"

@protocol remoteDataProtocol

@optional
- (void)setDataArray:(NSArray *)dataArray;
- (void)setDataDictionary:(NSDictionary *)dataDictionary;

@end

@interface EYLremoteConnection : NSObject

@property (nonatomic, weak) id<remoteDataProtocol> delegate;

- (void)getStopsByDistanceWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid;

@end
