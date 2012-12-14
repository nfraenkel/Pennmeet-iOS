//
//  PennMeetCreateGroupViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetCurrentLoggedInUser.h"

@interface PennMeetCreateGroupViewController : UIViewController


- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)doneButtonTouched:(id)sender;


@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@end