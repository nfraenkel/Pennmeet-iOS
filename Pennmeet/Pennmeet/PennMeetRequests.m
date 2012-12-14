//
//  PennMeetRequests.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetRequests.h"



@implementation PennMeetRequests 

NSString* apiToken = @"5vj8a8fxoktufbjegfv0";
NSString* accountToken = @"849315";



-(void)retrieveUser:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, apiToken];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];

    [request setHTTPMethod:@"GET"];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"conection did receive response!");
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"conection did receive data!");
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Please do something sensible here, like log the error.
    NSLog(@"connection failed with error: %@", error.description);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle: @"Error with GET"
//                          message: @"FUUUUUUUUU"
//                          delegate: self
//                          cancelButtonTitle:@"OK BYE"
//                          otherButtonTitles:@"Retry", nil];
//    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    NSString* identy = [dictResponse objectForKey:@"_id"];
    NSString* first = [dictResponse objectForKey:@"first"];
    NSString* last = [dictResponse objectForKey:@"last"];
    NSString* school = [dictResponse objectForKey:@"school"];
    NSString* major = [dictResponse objectForKey:@"major"];
    NSString* birthday = [dictResponse objectForKey:@"birthday"];
    PennMeetUser *user = [[PennMeetUser alloc] initWithId:identy andFirst:first andLast:last andSchool:school andMajor:major andBirthday:birthday];
    
    // TODO: do something with user
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
