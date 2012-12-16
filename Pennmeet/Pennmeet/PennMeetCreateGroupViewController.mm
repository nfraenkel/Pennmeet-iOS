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

UIImage* qrcodeImage;

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

//TextView delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
