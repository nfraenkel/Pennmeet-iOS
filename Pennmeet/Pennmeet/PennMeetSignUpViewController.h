//
//  PennMeetSignUpViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennmeetAppDelegate.h"

@interface PennMeetSignUpViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate> {
    NSMutableData *_data;
}
- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *photoUrlTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrolley;


@end
