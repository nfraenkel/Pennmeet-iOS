//
//  PennMeetLoginViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetAppDelegate.h"
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetUser.h"
#import "PennMeetSimplifiedGroup.h"

@interface PennMeetLoginViewController : UIViewController <UITextFieldDelegate, NSURLConnectionDataDelegate> {
    NSMutableData *_data;
}

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@property (retain) PennMeetUser *user;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrolley;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginPressed:(id)sender;
- (IBAction)signUpPressed:(id)sender;

@end
