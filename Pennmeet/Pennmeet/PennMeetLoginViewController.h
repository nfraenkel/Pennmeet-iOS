//
//  PennMeetLoginViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/16/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetAppDelegate.h"
#import "FacebookSDK.h"
#import "FBSession.h"

@interface PennMeetLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
- (IBAction)loginWithFacebookPressed:(id)sender;

@property (strong, nonatomic) UIActivityIndicatorView *spinner;

- (void)loginFailed;
- (void)openSession;


@end
