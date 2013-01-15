//
//  EYLnavigationControllerDelegate.m
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLnavigationControllerDelegate.h"

@implementation EYLnavigationControllerDelegate

@synthesize from;
@synthesize to;
@synthesize when;
@synthesize lonStart;
@synthesize latStart;
@synthesize language;
@synthesize country;
@synthesize isDeparture;
@synthesize isMetric;
@synthesize latEnd;
@synthesize lonEnd;

/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    LogDebug(@"SHOW");
    if ([viewController respondsToSelector:@selector(showData)]) {
        [viewController performSelector:@selector(showData)];
    }
    
}
 */

- (id) init {
    latStart = dStartLat;
    lonStart = dStartLon;
    latEnd = dEndLat;
    lonEnd = dEndLon;
    
    return self;
}

-(void)printMe{
    LogDebug(@"PRINT ME\nFROM: %@\nTO: %@\nWHEN: %@\nisDeparture: %i\nlatlon: %@,%@\nlang-country:%@-%@\nisMetric: %i",
             from,to,when,isDeparture,latStart,lonStart,language,country,isMetric);
}

@end
