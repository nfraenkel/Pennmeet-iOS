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

@interface PennMeetFirstViewController : UIViewController <NSURLConnectionDataDelegate> {
    NSMutableData *_data;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextView *majorLabel;
@property (weak, nonatomic) IBOutlet UITextView *birthdayLabel;

- (IBAction)editButtonPressed:(id)sender;

-(void)retrieveUser:(NSString *)identifier;

@end
