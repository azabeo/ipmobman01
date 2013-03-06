//
//  EYLViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 01/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLViewController.h"

@interface EYLViewController ()

@end

@implementation EYLViewController
@synthesize webView;

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
    
    NSString *testString = @"This will go to <a href = \"http://www.google.com\">Google</a>";
    [webView loadHTMLString:testString baseURL:nil];
    webView.delegate=self;
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request  navigationType:(UIWebViewNavigationType)navigationType{
    
    
    
    NSString * requestString=[[request URL] absoluteString];
    NSLog(@"%@ is requestString from clicking",requestString );
    
    [[UIApplication sharedApplication] openURL:[request URL]];
    
    if ([[[request URL] absoluteString] hasPrefix:@"http://www.google"]) {
        
        
        
        
        
    }
    return TRUE;
    
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
