//
//  PennMeetFirstViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetFirstViewController.h"

@interface PennMeetFirstViewController ()

@end

@implementation PennMeetFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // TODO: make this get the user who just logged in
    [self retrieveUser:@"fraenkel@seas.upenn.edu"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editButtonPressed:(id)sender {
    NSLog(@"EDITBUTTONPRESSED THO");
}

-(void)populateProfile:(PennMeetUser *)user {
    NSLog(@"WOULD POPULATE PROFILE AT THIS TIME");
    //TODO
    
}


-(void)retrieveUser:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

-(void)retrieveGroup:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/groups/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
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
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error with your request"
                          message: @"There was an error with your request."
                          delegate: self
                          cancelButtonTitle:@"OK BYE"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    if (dictResponse.count == 7){ // retrieveUser
        NSString* identy = [dictResponse objectForKey:@"_id"];
        NSString* first = [dictResponse objectForKey:@"first"];
        NSString* last = [dictResponse objectForKey:@"last"];
        NSString* school = [dictResponse objectForKey:@"school"];
        NSString* major = [dictResponse objectForKey:@"major"];
        NSString* birthday = [dictResponse objectForKey:@"birthday"];
        NSMutableArray* groups = [NSMutableArray array];
        NSDictionary *groupsDict = [dictResponse objectForKey:@"groups"];
        for (int i = 1; i <= groupsDict.count; i++){
            NSString* groupID = [groupsDict objectForKey:[NSString stringWithFormat:@"group%d", i]];
            [groups addObject:groupID];
        }
        PennMeetUser *user = [[PennMeetUser alloc] initWithId:identy andFirst:first andLast:last andSchool:school andMajor:major andBirthday:birthday andGroups:groups];
        
        [self populateProfile:user];
        
        
    }
    else if (dictResponse.count == 2){ // retrieveGroup
        NSMutableArray* members = [NSMutableArray array];
        NSString* identy = [dictResponse objectForKey:@"_id"];
        NSDictionary *membersDict = [dictResponse objectForKey:@"members"];
        for (int i = 1; i <= membersDict.count; i++){
            NSString* memb = [membersDict objectForKey:[NSString stringWithFormat:@"id%d", i]];
            [members addObject:memb];
        }
        PennMeetGroup *group = [[PennMeetGroup alloc] initWithName:identy andArray:members];
    }
    
    
    // TODO: do something with user
    
}
@end
