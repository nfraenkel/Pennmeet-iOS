//
//  PennMeetCreateGroupViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "PennMeetAppDelegate.h"
#import "PennMeetUser.h"
#import "PennMeetGroup.h"
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetSimplifiedGroup.h"
#import "QREncoder.h"

@interface PennMeetCreateGroupViewController : UIViewController <NSURLConnectionDataDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
    NSMutableData *_data;
}

@property (weak, nonatomic) IBOutlet UIImageView *qrCode;

- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)doneButtonTouched:(id)sender;

@property (retain, nonatomic) NSMutableDictionary *groupies;


@property (weak, nonatomic) IBOutlet UITextField *groupNameField;

@property (weak, nonatomic) IBOutlet UITextField *bannerURLField;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@end
