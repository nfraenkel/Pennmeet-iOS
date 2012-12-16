//
//  PennMeetLoginViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetLoginViewController.h"
#include <CommonCrypto/CommonDigest.h>

@interface PennMeetLoginViewController ()

@end

@implementation PennMeetLoginViewController

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
    
    [self.scrolley setContentSize:CGSizeMake(self.scrolley.frame.size.width, 600)];
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
    
     self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTabPage"]){
        
    }
    else if ([segue.identifier isEqualToString:@"showSignUp"]){
        
    }
}

-(void)validateUser:(NSString *)email andPass:(NSString *)pass {
    
    NSLog(@"email: \"%@\"", email);
    NSLog(@"password: \"%@\"", pass);
    NSLog(@"hash: \"%@\"", [self stringToSha1:pass]);
    
    if ([email isEqualToString:self.emailField.text]){
        if ([pass isEqualToString:self.passwordField.text]){
            
            self.currentUser.currentUser = self.user;
            [self performSegueWithIdentifier:@"showTabPage" sender:self];
        }
    }
          
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        if (textField == self.emailField){
            [self.scrolley setContentOffset:CGPointMake(self.scrolley.contentOffset.x, 80)];
        }
        else if (textField == self.passwordField){
            [self.scrolley setContentOffset:CGPointMake(self.scrolley.contentOffset.x, 100)];
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.passwordField){
        if ([string isEqualToString:@"\n"]){
            [self loginPressed:self];
            return YES;
        }
    }
    return YES;
}

- (IBAction)loginPressed:(id)sender {
    
    NSString* email = self.emailField.text;
    
    [self retrieveUser:email];
}

- (IBAction)signUpPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"showSignUp" sender:self];
}



-(NSString *)hashPassword:(NSString *)password {
    // Hash using the SHA-1 algorithm    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [password dataUsingEncoding: NSUTF8StringEncoding]; /* or some other encoding */
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        /* SHA-1 hash has been calculated and stored in 'digest'. */
    return [NSString stringWithFormat:@"%s", digest];
    }
    return nil;

}

-(NSString *)stringToSha1:(NSString *)str{
    NSMutableData *dataToHash = [[NSMutableData alloc] init];
    [dataToHash appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    unsigned char hashBytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([dataToHash bytes], [dataToHash length], hashBytes);
    NSData *encodedData = [NSData dataWithBytes:hashBytes length:CC_SHA1_DIGEST_LENGTH];
    NSString *encodedStr = [NSString stringWithUTF8String:[encodedData bytes]];
    NSLog(@"String is %@", encodedStr);
    
    return encodedStr;
    
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
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error: User Info"
//                          message: @"There was a network error when trying to fetch your profile information."
//                          delegate: self
//                          cancelButtonTitle:@"NVMD"];
//    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        // CANCEL
        
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    
    NSString* identy = [dictResponse objectForKey:@"_id"];
    NSString* first = [dictResponse objectForKey:@"first"];
    NSString* last = [dictResponse objectForKey:@"last"];
    NSString* school = [dictResponse objectForKey:@"school"];
    NSString* major = [dictResponse objectForKey:@"major"];
    NSString* birthday = [dictResponse objectForKey:@"birthday"];
    NSString* photoUrlTho = [dictResponse objectForKey:@"photoUrl"];
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
    self.user = [[PennMeetUser alloc] initWithId:identy andFirst:first andLast:last andSchool:school andMajor:major andBirthday:birthday andGroups:groups];
    
    self.user.photoUrl = photoUrlTho;


    NSString* pass = [dictResponse objectForKey:@"password"];
    
    [self validateUser:identy andPass:pass];
    
    
}
@end
