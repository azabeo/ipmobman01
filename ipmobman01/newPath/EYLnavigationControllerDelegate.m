//
//  EYLnavigationControllerDelegate.m
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLnavigationControllerDelegate.h"

@implementation EYLnavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    LogDebug(@"SHOW");
    if ([viewController respondsToSelector:@selector(showData)]) {
        [viewController performSelector:@selector(showData)];
    }
    
}

@end
