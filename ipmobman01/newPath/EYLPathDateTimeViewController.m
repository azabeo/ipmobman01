//
//  EYLPathDateTimeViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 18/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EYLPathDateTimeViewController.h"

@interface EYLPathDateTimeViewController ()

@end

@implementation EYLPathDateTimeViewController
@synthesize delegate;
@synthesize pathDatePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    }

- (void)viewDidUnload
{

    [self setPathDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.  

        [self.delegate setDate:[pathDatePicker date]];
    }
    [super viewWillDisappear:animated];
}

@end
