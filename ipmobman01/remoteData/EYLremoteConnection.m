//
//  EYLremoteConnection.m
//  ipmobman01
//
//  Created by Alex Zabeo on 03/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLremoteConnection.h"
NSMutableData *receivedData;

@implementation EYLremoteConnection
@synthesize delegate;

+ (NSString*)getStopsPostStringWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid Limit:(int)lim isMetric:(BOOL)ism{
    
    NSString* postString = [[[[[[[[[[[@"lat=" stringByAppendingString:lat] stringByAppendingString:@"&lon="] stringByAppendingString:lon] stringByAppendingString:@"&dist="] stringByAppendingString:[NSString stringWithFormat:@"%i", dist]] stringByAppendingString:@"&agid="] stringByAppendingString:agid] stringByAppendingString:@"&limitTo="]stringByAppendingString:[NSString stringWithFormat:@"%i", lim]] stringByAppendingString:@"&isMetric="]stringByAppendingString:(ism?@"TRUE":@"FALSE")];
    
    return postString;
}

- (void)getStopsByDistanceWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid Limit:(int)lim isMetric:(BOOL)ism{
    NSString* url = stopListServiceUrl;
    
    NSString* postString = [EYLremoteConnection getStopsPostStringWithLat:lat Lon:lon Dist:dist AgencyGlobalId:agid Limit:lim isMetric:ism];
    
    LogDebug(@"%@",url);
    LogDebug(@"%@",postString);
    
    [self connectToUrl:url withPostString:postString];
}

-(void)getTripOptionsWithOrigin:(NSString*)origin Destination:(NSString*)destination IsDeparture:(BOOL)isDeparture When:(NSString*)when Language:(NSString*)language IsMetric:(BOOL)isMetric{
    
    //maps.googleapis.com/maps/api/directions/json?origin=RE%20UMBERTO&destination=Fermata%201951%20-%20MONCALIERI&mode=transit&departure_time=1357657831&language=en&units=metric&alternatives=true&sensor=false
    
    NSString* url = [[[[@"http://maps.googleapis.com/maps/api/directions/json?origin=" stringByAppendingString:origin] stringByAppendingString:@"&destination="] stringByAppendingString:destination] stringByAppendingString:@"&mode=transit&"];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (isDeparture) {
        url = [url stringByAppendingString:@"departure_time="];
    }else {
        url = [url stringByAppendingString:@"arrival_time="];
    }
    
    url = [url stringByAppendingString:when];
    
    url = [[[url stringByAppendingString:@"&language="]stringByAppendingString:language]stringByAppendingString:@"&units="];
    
    if (isMetric) {
        url = [url stringByAppendingString:@"metric"];
    }else {
        url = [url stringByAppendingString:@"imperial"];
    }
    
    url=[url stringByAppendingString:@"&alternatives=true&sensor=true"];
    
    LogDebug(@"%@",url);
    
    [self connectToUrl:url];
}

-(BOOL)connectToUrl:(NSString *)url{
    NSURL *aUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request 
                                                                 delegate:self];
    
    if (connection) {
        receivedData = [NSMutableData data];
        LogInfo(@"CONNECTED!");
        return true;
    } else {
        // Inform the user that the connection failed.
        LogError(@"connection error");
        return false;
    }
}

- (BOOL)connectToUrl:(NSString*)url withPostString:(NSString*) postString{
    NSURL *aUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    //NSString *postString = @"lon=7.3136700000000001&lat=45.112850000000002&dist=2&agid=id1";
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request 
                                                                 delegate:self];
    
    if (connection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        
        receivedData = [NSMutableData data];
        LogInfo(@"CONNECTED!");
        return true;
    } else {
        // Inform the user that the connection failed.
        LogError(@"connection error");
        return false;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    // This method is called when the server has determined that it
    
    // has enough information to create the NSURLResponse.
    
    
    
    // It can be called multiple times, for example in the case of a
    
    // redirect, so each time we reset the data.
    
    
    
    // receivedData is an instance variable declared elsewhere.
    
    [receivedData setLength:0];
    
    //LogInfo(@"receiveResponse");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    // Append the new data to receivedData.
    
    // receivedData is an instance variable declared elsewhere.
    
    [receivedData appendData:data];
    
    //LogInfo(@"receiveData");
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error

{
    // inform the user
    
    LogError(@"Connection failed! Error - %@ %@",
          
          [error localizedDescription],
          
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{   
    LogInfo(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    NSString *myString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //LogDebug(@"RICEVUTI:\n %@",myString);
    
    //#INFO serve perchè l'hosting aggiunge scritte in cosa alle pagine
    NSRange range = [myString rangeOfString:@"<!-- Hosting24 Analytics Code -->"];
    if (range.location != NSNotFound) {
        myString = [myString substringToIndex:range.location];
        receivedData = (NSMutableData*)[myString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSError *jsonError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
    
    if (!jsonObject) {
        LogError(@"Error parsing JSON: %@", jsonError);
    } else {
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *jsonArray = (NSArray *)jsonObject;
            
            //#INFO Togliere
            //[NSThread sleepForTimeInterval:1.0f];
            
            [self.delegate setDataArray:jsonArray];
        }
        else {
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            
            //#INFO Togliere
            //[NSThread sleepForTimeInterval:1.0f];
            
            [self.delegate setDataDictionary:jsonDictionary];
        }
    }
}


@end

