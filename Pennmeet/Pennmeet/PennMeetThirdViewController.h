//
//  PennMeetThirdViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetCurrentLoggedInUser.h"


@interface PennMeetThirdViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *plusButton;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;



@end
