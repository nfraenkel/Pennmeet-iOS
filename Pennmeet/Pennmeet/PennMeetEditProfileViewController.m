//
//  PennMeetEditProfileViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/15/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetEditProfileViewController.h"

@interface PennMeetEditProfileViewController ()

@end

@implementation PennMeetEditProfileViewController

@synthesize firstNameTextField, lastNameTextField, emailTextField, photoUrlTextField, schoolTextField, majorTextField, birthdayTextField;
@synthesize firstOriginal, lastOriginal, photoOriginal, schoolOriginal, majorOriginal, birthdayOriginal;
@synthesize currentUser, hasChangedAnything, saveButton, scrolley;

CGPoint oldContentOffset;

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
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
        
    firstNameTextField.text = currentUser.currentUser.first;
    lastNameTextField.text = currentUser.currentUser.last;
    emailTextField.text = currentUser.currentUser.uniqueID;
    photoUrlTextField.text = currentUser.currentUser.photoUrl;
    schoolTextField.text = currentUser.currentUser.school;
    majorTextField.text = currentUser.currentUser.major;
    birthdayTextField.text = currentUser.currentUser.birthday;
    
    firstNameTextField.delegate = self;
    lastNameTextField.delegate = self;
    photoUrlTextField.delegate = self;
    schoolTextField.delegate = self;
    majorTextField.delegate = self;
    birthdayTextField.delegate = self;
    
    firstOriginal = currentUser.currentUser.first;
    lastOriginal = currentUser.currentUser.last;
    photoOriginal = currentUser.currentUser.photoUrl;
    schoolOriginal = currentUser.currentUser.school;
    majorOriginal = currentUser.currentUser.major;
    birthdayOriginal = currentUser.currentUser.birthday;
    
    scrolley.delegate = self;
    scrolley.contentSize = CGSizeMake(320, 600);
    scrolley.scrollEnabled = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setReturnKeyType:UIReturnKeyDone];

    saveButton.enabled = NO;
    oldContentOffset = scrolley.contentOffset;
    
    // hardcoded scrollview values to get text above keyboard
    [UIView animateWithDuration:0.5 animations:^{
        if (textField == schoolTextField){
            scrolley.contentOffset = CGPointMake(scrolley.contentOffset.x, 70);
        }
        else if (textField == majorTextField){
            scrolley.contentOffset = CGPointMake(scrolley.contentOffset.x, 130);
        }
        else if (textField == birthdayTextField){
            scrolley.contentOffset = CGPointMake(scrolley.contentOffset.x, 190);
        }
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    // set scrollview back to where it was before editing
    [UIView animateWithDuration:0.5 animations:^{
        scrolley.contentOffset = oldContentOffset;
    }];
    
    // see if anything has changed --> if yes, give ability to SAVE
    self.hasChangedAnything = [self checkIfAnythingIsDifferent];
    if (hasChangedAnything){
        [self.saveButton setEnabled:YES];
    }
    else {
        [self.saveButton setEnabled:NO];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)checkIfAnythingIsDifferent {
    if (![firstNameTextField.text isEqualToString:firstOriginal])
        return YES;
    if (![lastNameTextField.text isEqualToString:lastOriginal])
        return YES;
    if (![photoUrlTextField.text isEqualToString:photoOriginal])
        return YES;
    if (![schoolTextField.text isEqualToString:schoolOriginal])
        return YES;
    if (![majorTextField.text isEqualToString:majorOriginal])
        return YES;
    if (![birthdayTextField.text isEqualToString:birthdayOriginal])
        return YES;
    return NO;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    return NO;
//}


- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"EDITING PROFILE CANCELLED THO");
    }];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"EDITING PROFILE SAVED THO");
    }];
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
                          message: @"There was a network error when trying to update your profile information."
                          delegate: self
                          cancelButtonTitle:@"W/E"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        // CANCEL
        
    }
    else if (buttonIndex == 1){
        // RETRY
//        [self retrieveUser:username];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    
    
    
    // TODO: do something with user
    
}






@end
