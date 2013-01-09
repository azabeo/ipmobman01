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

- (void)getStopsByDistanceWithLat:(NSString*)lat Lon:(NSString*)lon Dist:(int)dist AgencyGlobalId:(NSString*)agid{
    NSString* url = @"http://localhost/PhpProject2/stopsListService/stopsListService.php";
    
    NSString* postString = [[[[[[[@"lat=" stringByAppendingString:lat] stringByAppendingString:@"&lon="] stringByAppendingString:lon] stringByAppendingString:@"&dist="] stringByAppendingString:[NSString stringWithFormat:@"%i", dist]] stringByAppendingString:@"&agid="] stringByAppendingString:agid];
    
    LogDebug(@"%@",postString);
    
    [self connectToUrl:url withPostString:postString];
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
    
    LogInfo(@"receiveResponse");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    // Append the new data to receivedData.
    
    // receivedData is an instance variable declared elsewhere.
    
    [receivedData appendData:data];
    
    LogInfo(@"receiveData");
    
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
    
    //NSString *myString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //LogDebug(@"%@",myString);
    
    NSError *jsonError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
    
    if (!jsonObject) {
        LogError(@"Error parsing JSON: %@", jsonError);
    } else {
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *jsonArray = (NSArray *)jsonObject;
            
            [self.delegate setDataArray:jsonArray];
        }
        else {
            NSLog(@"its probably a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
            
            [self.delegate setDataDictionary:jsonDictionary];
        }
    }
}


@end

