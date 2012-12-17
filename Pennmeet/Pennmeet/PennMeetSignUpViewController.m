//
//  PennMeetSignUpViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetSignUpViewController.h"

@interface PennMeetSignUpViewController ()

@end

@implementation PennMeetSignUpViewController

@synthesize firstNameTextField, lastNameTextField, emailTextField, schoolTextField, photoUrlTextField, majorTextField, birthdayTextField, passwordField, confirmField, scrolley;


CGPoint base;

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
    
    scrolley.delegate = self;
    scrolley.contentSize = CGSizeMake(320, 600);
    scrolley.scrollEnabled = NO;
    
    firstNameTextField.delegate = self;
    lastNameTextField.delegate = self;
    emailTextField.delegate = self;
    passwordField.delegate = self;
    confirmField.delegate = self;
    photoUrlTextField.delegate = self;
    schoolTextField.delegate = self;
    majorTextField.delegate = self;
    birthdayTextField.delegate = self;
    
    base = CGPointMake(0, 0);


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        if (textField == photoUrlTextField){
            [scrolley setContentOffset:CGPointMake(scrolley.contentOffset.x, 50)];
        }
        else if (textField == schoolTextField) {
            [scrolley setContentOffset:CGPointMake(scrolley.contentOffset.x, 100)];
        }
        else if (textField == majorTextField) {
            [scrolley setContentOffset:CGPointMake(scrolley.contentOffset.x, 150)];
        }
        else if (textField == birthdayTextField) {
            [scrolley setContentOffset:CGPointMake(scrolley.contentOffset.x, 200)];
        }
    }];
}




-(void)textFieldDidEndEditing:(UITextField *)textField {

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.5 animations:^{
            [scrolley setContentOffset:base];
        }];
        return NO;
    }
    return YES;
}

- (IBAction)cancelPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)donePressed:(id)sender {
    BOOL validFields = [self validateFields];
    if (validFields){
        NSString *photo;
        if ([photoUrlTextField.text isEqualToString:@""]){
            photo = [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] defaultPhotoUrl];
        }
        else {
            photo = photoUrlTextField.text;
        }
        
//        [self createUser:emailTextField.text];
        NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:emailTextField.text, @"_id", passwordField.text, @"password", firstNameTextField.text, @"first", lastNameTextField.text, @"last", schoolTextField.text, @"school", majorTextField.text, @"major", birthdayTextField.text, @"birthday", photo, @"photoUrl", [[NSDictionary alloc] init], @"groups", nil];
        NSDictionary *userDict = [[NSDictionary alloc] initWithObjectsAndKeys:temp, @"document", nil];
        
        NSLog(@"user: %@", userDict);
        
        [self postUser:userDict];
        
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"INVALID SIGNUP FIELDS");
        }];
    }

}

-(BOOL)validateFields {
    if ([passwordField.text isEqualToString:confirmField.text] && ![passwordField.text isEqualToString:@""]){
        if (![firstNameTextField.text isEqualToString:@""]){
            if (![lastNameTextField.text isEqualToString:@""]){
                if (![birthdayTextField.text isEqualToString:@""]){
                    if (![schoolTextField.text isEqualToString:@""]){
                        if (![majorTextField.text isEqualToString:@""]){
                            return YES;
                        }
                        
                    }
                }
            }
        }
    }
    return NO;
}




-(void)postUser:(NSDictionary *)dict{
    NSData *data;
    if ([NSJSONSerialization isValidJSONObject:dict]){
        data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    }
    else {
        NSLog(@"CANTTTTTTT");
        return;
    }
    
    NSLog(@"nsdata: %@", data);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *api = [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken];
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents?_apikey=%@", api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPBody:data];
    
    [request setHTTPMethod:@"POST"];
    
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
                          otherButtonTitles:nil, nil];
    [alert show];
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
    NSLog(@"response dict: %@", dictResponse);

    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

@end
