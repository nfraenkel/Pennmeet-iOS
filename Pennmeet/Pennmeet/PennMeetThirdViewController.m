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
    [self getRequest:self.currentUser.currentUser.uniqueID];
    
    
    
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
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"QRCode"
                          message: text
                          delegate: self
                          cancelButtonTitle:@"Remove"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
    
    [reader dismissViewControllerAnimated: YES completion:nil];
}

-(void)getRequest:(NSString*) identifier {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/users/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
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


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    
    //Check to see if response is a user
    if([dictResponse objectForKey:@"password"] != nil) {
        
        self.usersGroups = [[NSMutableDictionary alloc] initWithDictionary:[dictResponse objectForKey:@"groups"]];
        
        groupCount = [self.usersGroups count];
        
    }
    //Check to see if response is a group
    if([dictResponse objectForKey:@"members"] != nil) {
        self.scannedGroup = [[NSMutableDictionary alloc] initWithDictionary:dictResponse];
    }
    NSLog(@"response dict: %@", dictResponse);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

@end
