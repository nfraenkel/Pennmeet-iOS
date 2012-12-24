//
//  PennMeetThirdViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetThirdViewController.h"

@interface PennMeetThirdViewController ()

@end

@implementation PennMeetThirdViewController

@synthesize plusButton;
@synthesize usersGroups;
@synthesize scannedGroup;

int groupCount;
int userRequests = -1;

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
    //[self getRequest:self.currentUser.currentUser.uniqueID];
    
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
//    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [plusButton addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
   
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //Set to still captures only
   cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

// handle method
- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"GENERATE QR CODE SCANNER!!!");
    /*
     [self startCameraControllerFromViewController:self usingDelegate:self];
     */
    [self startZBarController:self usingDelegate:self];

}

-(BOOL) startZBarController: (UIViewController*) controller
usingDelegate:(id <ZBarReaderDelegate>) delegate{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;

    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader
                       animated:YES completion:nil];
    return YES;
}


//ZBAR DELEGATE
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    
    NSString* text = symbol.data;
    NSLog(@"Fetching group with id: %@", text);
    [self getRequest:text getType:@"groups"];

    
    [reader dismissViewControllerAnimated: YES completion:nil];
}

-(void)getRequest:(NSString*) identifier getType:(NSString*) type{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/%@/documents/%@?_apikey=%@", type, identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connection did receive response!");
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"connection did receive data!");
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Please do something sensible here, like log the error.
    NSLog(@"connection failed with error: %@", error.description);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error: User Info"
                          message: @"There was a network error when trying request group."
                          delegate: self
                          cancelButtonTitle:@"NVMD"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

-(void)putRequest:(NSDictionary *) dict getType:(NSString *) type {
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
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/%@/documents/%@?_apikey=%@", type, self.currentUser.currentUser.uniqueID, api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //[request setValuesForKeysWithDictionary:dict];
    [request setHTTPBody:data];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    
    NSLog(@"response dict: %@", dictResponse);
    //Check to see if response is a user
    if([dictResponse objectForKey:@"password"] != nil) {
        
        self.usersGroups = [[NSMutableDictionary alloc] initWithDictionary:[dictResponse objectForKey:@"groups"]];
        
        groupCount = [self.usersGroups count];
        
    }
    //Check to see if response is a group
    if([dictResponse objectForKey:@"members"] != nil) {
        self.scannedGroup = [[NSMutableDictionary alloc] initWithDictionary:dictResponse];
        NSLog(@"Recieved group from QR Scan!");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"QRCode"
                              message: @"Sent request to group!"
                              delegate: self
                              cancelButtonTitle:@"Remove"
                              otherButtonTitles:@"Retry", nil];
        [alert show];
        
        NSMutableDictionary *totalRequestsInGroup = [[NSMutableDictionary alloc] initWithDictionary:[self.scannedGroup objectForKey:@"requests"]];
        userRequests = [totalRequestsInGroup count];
        
        NSLog(@"userRequest Count: %d", userRequests);
        NSString* formatRequest;
        //Put user in group requests
        if(userRequests > -1) {

            userRequests++;
            NSLog(@"Sending request for id%d", userRequests);
            formatRequest = [NSString stringWithFormat:@"id%d", userRequests];
            
            [totalRequestsInGroup setObject:self.currentUser.currentUser.uniqueID forKey:formatRequest];
            
            NSDictionary* groupPutRequest = [[NSDictionary alloc] initWithObjectsAndKeys:totalRequestsInGroup, @"requests", nil];
            
            NSDictionary* incRequest = [[NSDictionary alloc] initWithObjectsAndKeys:groupPutRequest, @"$set", nil];
            
            NSDictionary* putDict = [[NSDictionary alloc] initWithObjectsAndKeys:incRequest, @"document", nil];
            
            NSLog(@"Attempting to put request");
            NSLog(@"putRequest: %@", putDict);
            
            [self putRequest:putDict getType:@"groups"];
        }
    }

    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

@end
