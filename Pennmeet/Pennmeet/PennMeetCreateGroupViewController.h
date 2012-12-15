//
//  PennMeetCreateGroupViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetAppDelegate.h"
#import "PennMeetUser.h"
#import "PennMeetGroup.h"
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetSimplifiedGroup.h"
//#import "QREncoder.h"

@interface PennMeetCreateGroupViewController : UIViewController <NSURLConnectionDataDelegate, UIAlertViewDelegate> {
    NSMutableData *_data;
}


- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)doneButtonTouched:(id)sender;


@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@end
