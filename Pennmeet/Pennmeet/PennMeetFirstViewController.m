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

@synthesize currentUser, firstNameLabel, lastNameLabel, emailLabel, schoolLabel, majorLabel, birthdayLabel, userImage, navy, editorz
;

//NSString* username = @"fraenkel@seas.upenn.edu";
//NSString* username = @"zhangb@seas.upenn.edu";
BOOL userRetrieved;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"PROFILE viewdidload");
    
    
    // clear all labels initially
    firstNameLabel.text = @"";
    lastNameLabel.text = @"";
    emailLabel.text = @"";
    schoolLabel.text = @"";
    majorLabel.text = @"";
    birthdayLabel.text = @"";
    
    userRetrieved = NO;
    
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
        
    // TODO: make this get the user who just logged in
    [self retrieveUser:self.currentUser.currentUser.uniqueID];
    
    
}

- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 self.firstNameLabel.text = user.name;
                 self.lastNameLabel.text = user.name;
//                 self.userProfileImage.profileID = [user objectForKey:@"id"];
             }
         }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editButtonPressed:(id)sender {
    NSLog(@"EDITBUTTONPRESSED THO");
    // TODO: editing
//    [self populateProfile:currentUser.currentUser];
//    [self presentViewController:[[PennMeetEditProfileViewController alloc] init] animated:YES completion:^{
        NSLog(@"YAAAAAA");
//    }];
    [self performSegueWithIdentifier:@"showEditProfile" sender:self];
}

- (IBAction)refresherPressed:(id)sender {
    NSLog(@"refresh!!!!!!");
    [self retrieveUser:self.currentUser.currentUser.uniqueID];
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"PROFILE viewdidappear");
    [self refresherPressed:self];
}

-(void)viewDidDisappear:(BOOL)animated {
    NSLog(@"PROFILE viewdiddisappear");

//    [self populateProfile:currentUser.currentUser];

}

-(void)populateProfile:(PennMeetUser *)user {
    NSLog(@"POPULATE PROFILE AT THIS TIME");
    
    // get profile picture from online
    UIImage *profImage = [self imageFromURLString:user.photoUrl];
    
//    // determine new width/height based on ratio of photo
//    double width = profImage.size.width;
//    double height = profImage.size.height;
//    double heightOverWidth = height / width;
//    
//    double newHeight = userImage.frame.size.width * heightOverWidth;
    
    
    // get height change/diff
//    double diff = newHeight - userImage.frame.size.height;
    
    [self.userImage setImage:profImage];
    
    // create new frame based on image width/height ratio
//    self.userImage.frame = CGRectMake(userImage.frame.origin.x, userImage.frame.origin.y, userImage.frame.size.width, newHeight);
    
    
    // move all labels accordingly to new height diff
//    emailLabel.frame = CGRectMake(emailLabel.frame.origin.x, self.userImage.frame.origin.y + self.userImage.frame.size.height + 30, emailLabel.frame.size.width, emailLabel.frame.size.height);
//    schoolLabel.frame = CGRectMake(schoolLabel.frame.origin.x, self.emailLabel.frame.origin.y + self.emailLabel.frame.size.height + 6, schoolLabel.frame.size.width, schoolLabel.frame.size.height);
//    majorLabel.frame = CGRectMake(majorLabel.frame.origin.x, schoolLabel.frame.origin.y + schoolLabel.frame.size.height + 6, majorLabel.frame.size.width, majorLabel.frame.size.height);
//    birthdayLabel.frame = CGRectMake(birthdayLabel.frame.origin.x, majorLabel.frame.origin.y + majorLabel.frame.size.height + 6, birthdayLabel.frame.size.width, birthdayLabel.frame.size.height);
    
    // set labels texts
//    firstNameLabel.text = [NSString stringWithFormat:@"%@", user.first];
//    lastNameLabel.text = [NSString stringWithFormat:@"%@", user.last];
    emailLabel.text = [NSString stringWithFormat:@"%@", user.uniqueID];
    schoolLabel.text = [NSString stringWithFormat:@"%@", user.school];
    majorLabel.text = [NSString stringWithFormat:@"%@", user.major];
    birthdayLabel.text = [NSString stringWithFormat:@"%@", user.birthday];
    
    [self populateUserDetails];
}

// HELPER - returns image from url. so sexy
- (UIImage *)imageFromURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //    [request release];
    //    [self handleError:error];
    UIImage *resultImage = [UIImage imageWithData:(NSData *)result];
    
//    NSLog(@"urlString: %@",urlString);
    return resultImage;
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
        [self retrieveUser:self.currentUser.currentUser.uniqueID];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    NSLog(@"dict response: %@", dictResponse);
    NSString* identy = [dictResponse objectForKey:@"_id"];
    NSString* first = [dictResponse objectForKey:@"first"];
    NSString* last = [dictResponse objectForKey:@"last"];
    NSString* school = [dictResponse objectForKey:@"school"];
    NSString* major = [dictResponse objectForKey:@"major"];
    NSString* birthday = [dictResponse objectForKey:@"birthday"];
    NSString* photoUrlTho = [dictResponse objectForKey:@"photoUrl"];
    NSMutableArray* groups = [NSMutableArray array];
    NSDictionary *groupsDict = [dictResponse objectForKey:@"groups"];
    NSLog(@"%@ %@ %@ %@ %@ %@", identy, first, last, school, major, birthday);
    NSLog(@"groups count: %d", groupsDict.count);
    for (int i = 1; i <= groupsDict.count; i++){
        NSDictionary *singleGroupDict = [groupsDict objectForKey:[NSString stringWithFormat:@"group%d", i]];
        
        NSString *gID = [singleGroupDict objectForKey:@"id"];
        NSString *gName = [singleGroupDict objectForKey:@"name"];
        NSString *gAdminPref = [singleGroupDict objectForKey:@"admin"];
        
        PennMeetSimplifiedGroup *sGroup = [[PennMeetSimplifiedGroup alloc] initWithID:gID andName:gName andAdmin:gAdminPref];
                    
        [groups addObject:sGroup];
    }
    PennMeetUser *user = [[PennMeetUser alloc] initWithId:identy andFirst:first andLast:last andSchool:school andMajor:major andBirthday:birthday andGroups:groups];
    
    user.photoUrl = photoUrlTho;

    // UPDATE OUR SINGLETON
    currentUser.currentUser = user;
    
    
    userRetrieved = YES;
    
    [self populateProfile:user];
    
    
    // TODO: do something with user
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEditProfile"]){
//        [self refresherPressed:self];
    }
}

@end
