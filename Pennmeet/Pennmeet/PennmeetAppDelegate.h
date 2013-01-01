//
//  PennMeetAppDelegate.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookSDK.h"
#import "PennMeetCurrentLoggedInUser.h"


@interface PennMeetAppDelegate : UIResponder <UIApplicationDelegate>

extern NSString *const FBSessionStateChangedNotification;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *apiToken, *accountToken, *defaultPhotoUrl;

//@property (strong, nonatomic) FBSession *session;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;




@end
