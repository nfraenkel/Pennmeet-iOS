//
//  PennMeetLoginViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetLoginViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTabPage"]){
        
    }
}

- (IBAction)loginWithFacebookPressed:(id)sender {
//    [self performSegueWithIdentifier:@"showTabPage" sender:self];
    
    [self.spinner startAnimating];
    
    [self performSegueWithIdentifier:@"showTabPage" sender:self];
    
    // FBSample logic
    // The user has initiated a login, so call the openSession method.
//    [self openSession];
}

//- (void)openSession
//{
//    [FBSession openActiveSessionWithReadPermissions:nil
//                                       allowLoginUI:YES
//                                  completionHandler:
//     ^(FBSession *session,
//       FBSessionState state, NSError *error) {
//         [self sessionStateChanged:session state:state error:error];
//     }];
//}
//
//- (void)sessionStateChanged:(FBSession *)session
//                      state:(FBSessionState) state
//                      error:(NSError *)error
//{
//    switch (state) {
//        case FBSessionStateOpen: {
//            UIViewController *topViewController =
//            [self.navController topViewController];
//            if ([[topViewController modalViewController]
//                 isKindOfClass:[SCLoginViewController class]]) {
//                [topViewController dismissModalViewControllerAnimated:YES];
//            }
//        }
//            break;
//        case FBSessionStateClosed:
//        case FBSessionStateClosedLoginFailed:
//            // Once the user has logged in, we want them to
//            // be looking at the root view.
//            [self.navController popToRootViewControllerAnimated:NO];
//            
//            [FBSession.activeSession closeAndClearTokenInformation];
//            
//            [self showLoginView];
//            break;
//        default:
//            break;
//    }
//    
//    if (error) {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"Error"
//                                  message:error.localizedDescription
//                                  delegate:nil
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//        [alertView show];
//    }
//}
//
//- (void)loginFailed {
//    
//}


@end
