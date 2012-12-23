//
//  PennMeetThirdViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "PennMeetCurrentLoggedInUser.h"
#import "ZBarSDK.h"
#import "PennMeetAppDelegate.h"




@interface PennMeetThirdViewController : UIViewController <UIGestureRecognizerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZBarReaderDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate> {
    NSMutableData *_data;
}

@property (nonatomic, weak) IBOutlet UIImageView *plusButton;

@property (retain, nonatomic) NSMutableDictionary *usersGroups;
@property(retain, nonatomic) NSMutableDictionary *scannedGroup;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@property (weak, nonatomic) IBOutlet UIImageView *cameraOutlet;


@end
