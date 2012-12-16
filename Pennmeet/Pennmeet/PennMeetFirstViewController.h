//
//  PennMeetFirstViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetAppDelegate.h"
#import "PennMeetUser.h"
#import "PennMeetGroup.h"
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetSimplifiedGroup.h"

@interface PennMeetFirstViewController : UIViewController <NSURLConnectionDataDelegate, UIAlertViewDelegate> {
    NSMutableData *_data;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresher;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextView *majorLabel;
@property (weak, nonatomic) IBOutlet UITextView *birthdayLabel;

- (IBAction)editButtonPressed:(id)sender;
- (IBAction)refresherPressed:(id)sender;

-(void)retrieveUser:(NSString *)identifier;

@end
