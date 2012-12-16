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
    
    [self startCameraControllerFromViewController:self usingDelegate:self];
    
    
    
    // TODO: bring up qr code scanner/ camera
    
//    PennMeetRequests *pm = [[PennMeetRequests alloc] init];
//    [pm retrieveUser:@"fraenkel@seas.upenn.edu"];
//    [pm retrieveGroup:@"KoolKidsKlub"];
    
//    NuMongoDB *mongo = [NuMongoDB new];
//	[mongo connectWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
//							   @"127.0.0.1", @"host", nil]];
//    
//	NSString *collection = @"test.sample";
//    
//	[mongo dropCollection:@"sample" inDatabase:@"test"];
//    
//	id sample = [NSDictionary dictionaryWithObjectsAndKeys:
//				 [NSNumber numberWithInt:1], @"one",
//				 [NSNumber numberWithDouble:2.0], @"two",
//				 @"3", @"three",
//				 [NSArray arrayWithObjects:@"zero", @"one", @"two", @"three", nil], @"four",
//				 nil];
//	[mongo insertObject:sample intoCollection:collection];
//    
//	id first = [mongo findOne:nil inCollection:collection];
//	NSLog(@"%@", first);
}

// Camera Controller delegate

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];

}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
    
        
        // Save the new image (original or edited) to the Camera Roll
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
}
@end
