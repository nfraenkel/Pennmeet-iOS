//
//  PennMeetAppDelegate.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PennMeetAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *apiToken, *accountToken, *defaultPhotoUrl;

//@property (strong, nonatomic) UINavigationController *navController;
//@property (strong, nonatomic) UITabBarController *mainViewController;
//@property (strong, nonatomic) PennMeetLoginViewController* loginViewController;



//- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
//- (void)openSession;




@end
