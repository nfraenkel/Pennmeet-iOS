//
//  PennMeetEditProfileViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/15/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetAppDelegate.h"

@interface PennMeetEditProfileViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, NSURLConnectionDataDelegate>{
    NSMutableData *_data;

}
@property (retain) PennMeetCurrentLoggedInUser *currentUser;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic) BOOL hasChangedAnything;

@property (nonatomic, copy) NSString *firstOriginal, *lastOriginal, *photoOriginal, *schoolOriginal, *majorOriginal, *birthdayOriginal;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *photoUrlTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrolley;


@end
