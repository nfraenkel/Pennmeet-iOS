//
//  PennMeetCreateGroupViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetCreateGroupViewController.h"

@interface PennMeetCreateGroupViewController ()

@end

@implementation PennMeetCreateGroupViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateQR:(NSString *)groupKey{
    
}

-(void)createGroup:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}


- (IBAction)cancelButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"CANCELLED GROUP CREATION");
    }];
}

- (IBAction)doneButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"DONE WITH GROUP CREATION");
    }];
    
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
-(void)alertView:(UIAlertView *)alertView {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
       
    // TODO: do something with user
    
}
@end
