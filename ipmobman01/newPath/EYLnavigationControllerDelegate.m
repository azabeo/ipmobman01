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
@synthesize cityName;

NSDateFormatter *timeFormatter;
NSDateFormatter *fixedDateFormatter;

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
    
    when = [NSDate date];
    
    timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateStyle:dDateStyle];
    
    fixedDateFormatter = [[NSDateFormatter alloc]init];
    [fixedDateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    return self;
}

-(NSString*)whenEpoch{
    return [NSString stringWithFormat:@"%i",(int)[when timeIntervalSince1970]];
}

-(NSString*) whenString{
    if ([[fixedDateFormatter stringFromDate:when] isEqualToString:[fixedDateFormatter stringFromDate:[NSDate date]]]) {
        [timeFormatter setTimeStyle:NSDateFormatterNoStyle];
    } else {
        [timeFormatter setTimeStyle:dTimeStyle];
    }
    
    return [timeFormatter stringFromDate: when];
}

-(NSString*) departureString{
    if (isDeparture) {
        return NSLocalizedString(@"Departure", "Departure");
    } else {
        return NSLocalizedString(@"Arrival", "Arrival");
    }
}

-(void)printMe{
    LogDebug(@"PRINT ME\nFROM: %@\nTO: %@\nWHEN: %@\nisDeparture: %i\nlatlon: %@,%@\nlang-country:%@-%@\nisMetric: %i",
             from,to,when,isDeparture,latStart,lonStart,language,country,isMetric);
}

@end
