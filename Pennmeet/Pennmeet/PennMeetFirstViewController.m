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

@synthesize currentUser, nameLabel, emailLabel, schoolLabel, majorLabel, birthdayLabel;

//NSString* username = @"fraenkel@seas.upenn.edu";
NSString* username = @"zhangb@seas.upenn.edu";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
    
    // TODO: make this get the user who just logged in
    [self retrieveUser:username];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editButtonPressed:(id)sender {
    NSLog(@"EDITBUTTONPRESSED THO");
    // TODO: editing
}

- (IBAction)refresherPressed:(id)sender {
    [self retrieveUser:username];
}

-(void)populateProfile:(PennMeetUser *)user {
    NSLog(@"POPULATE PROFILE AT THIS TIME");
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.first, user.last];
    emailLabel.text = [NSString stringWithFormat:@"%@", user.uniqueID];
    schoolLabel.text = [NSString stringWithFormat:@"%@", user.school];
    majorLabel.text = [NSString stringWithFormat:@"%@", user.major];
    birthdayLabel.text = [NSString stringWithFormat:@"%@", user.birthday];
    
}


-(void)retrieveUser:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
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
                          initWithTitle: @"Error: User Info"
                          message: @"There was a network error when trying to fetch your profile information."
                          delegate: self
                          cancelButtonTitle:@"NVMD"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        // CANCEL
        
    }
    else if (buttonIndex == 1){
        // RETRY
        [self retrieveUser:username];
    }
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
        NSLog(@"count: %d", groupsDict.count);
        for (int i = 1; i <= groupsDict.count; i++){
            NSDictionary *singleGroupDict = [groupsDict objectForKey:[NSString stringWithFormat:@"group%d", i]];
            
            NSString *gID = [singleGroupDict objectForKey:@"id"];
            NSString *gName = [singleGroupDict objectForKey:@"name"];
            NSString *gAdminPref = [singleGroupDict objectForKey:@"admin"];
            
            PennMeetSimplifiedGroup *sGroup = [[PennMeetSimplifiedGroup alloc] initWithID:gID andName:gName andAdmin:gAdminPref];
                        
            [groups addObject:sGroup];
            
        }
        PennMeetUser *user = [[PennMeetUser alloc] initWithId:identy andFirst:first andLast:last andSchool:school andMajor:major andBirthday:birthday andGroups:groups];
    
        // UPDATE OUR SINGLETON
        currentUser.currentUser = user;
        
        // populate user profile page/ labels with singleton info
        [self populateProfile:user];
        
        
    }
    
    
    // TODO: do something with user
    
}
@end
