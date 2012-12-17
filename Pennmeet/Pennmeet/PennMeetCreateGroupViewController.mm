//
//  PennMeetCreateGroupViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetCreateGroupViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface PennMeetCreateGroupViewController ()

@end

@implementation PennMeetCreateGroupViewController

UIImage* qrcodeImage;
int groupCount = -1;

@synthesize qrCode = _qrCode;
@synthesize groupNameField = _groupNameField;
@synthesize bannerURLField = _bannerURLField;

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
    
    self.groupNameField.delegate = self;
    self.bannerURLField.delegate = self;
    
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
    [self getUserGroups:self.currentUser.currentUser.uniqueID];
}

- (IBAction)generateQRImage:(id)sender {
    
    int qrcodeImageDimension = 320;
    UIButton *button = (UIButton *)sender;
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:self.groupNameField.text];
    
    //then render the matrix
    qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
    //put the image into the view
    [_qrCode setImage:qrcodeImage];
    
    
    [button removeFromSuperview];
}

- (IBAction)saveQRImage:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(qrcodeImage, nil, nil, nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"CANCELLED GROUP CREATION");
    }];
}

- (IBAction)doneButtonTouched:(id)sender {
    
    NSString *photo;
    photo = self.bannerURLField.text;

    
    NSString *hashedID = [PennMeetCreateGroupViewController digest:self.groupNameField.text];
    NSLog(@"hash name: %@", hashedID);

    
    //        [self createUser:emailTextField.text];
    // group post construction
    NSString* nameString = [NSString stringWithFormat:@"%@ %@", self.currentUser.currentUser.first, self.currentUser.currentUser.last];
    
    NSDictionary* userJson =[[NSDictionary alloc] initWithObjectsAndKeys:self.currentUser.currentUser.uniqueID, @"id1", nameString, @"name1", nil];
    
    NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:hashedID, @"_id", self.groupNameField.text, @"name", photo, @"photoUrl", userJson, @"members", nil];
        
    NSLog(@"userJson: %@", userJson);
    
    NSDictionary *groupDict = [[NSDictionary alloc] initWithObjectsAndKeys:temp, @"document", nil];
    
    NSLog(@"group: %@", groupDict);
    
    NSString *groupNumberInUser;
    // put into user
    if(groupCount != -1) {
        groupCount++;
        groupNumberInUser = [NSString stringWithFormat:@"group%d", groupCount];
    }
    NSDictionary* groupInUser = [[NSDictionary alloc] initWithObjectsAndKeys:self.groupNameField.text, @"id", self.groupNameField.text, @"name", @"YES", @"admin", nil];
    if(groupNumberInUser != nil) {
        NSDictionary* groupInUserWrapper = [[NSDictionary alloc]initWithObjectsAndKeys:groupInUser, groupNumberInUser, nil];
        
        NSDictionary* userPutRequest = [[NSDictionary alloc] initWithObjectsAndKeys:groupInUserWrapper, @"groups", nil];
        NSDictionary* incRequest = [[NSDictionary alloc] initWithObjectsAndKeys:userPutRequest, @"$inc", nil];
        NSDictionary* putDict = [[NSDictionary alloc] initWithObjectsAndKeys:incRequest, @"document", nil];
        NSLog(@"userPostrequest: %@", putDict);
        [self putInUser:putDict];
    }

    
    [self postGroup:groupDict];
   
    
    
}

-(void)getUserGroups:(NSString*) identifier {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

-(void)putInUser:(NSDictionary *) dict {
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
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", self.currentUser.currentUser.uniqueID, api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //[request setValuesForKeysWithDictionary:dict];
    [request setHTTPBody:data];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

}

-(void)postGroup:(NSDictionary *) dict {
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
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/groups/documents?_apikey=%@", api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //[request setValuesForKeysWithDictionary:dict];
    [request setHTTPBody:data];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
       
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    
    if([dictResponse objectForKey:@"password"] != nil) {
        NSDictionary* groups = [dictResponse objectForKey:@"groups"];
        
        groupCount = [groups count];
        
    }
    NSLog(@"response dict: %@", dictResponse);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

//TextView delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

+(NSString*) digest:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}
@end
