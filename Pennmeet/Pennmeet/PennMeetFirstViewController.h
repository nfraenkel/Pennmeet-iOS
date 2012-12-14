//
//  PennMeetFirstViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PennMeetFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)editButtonPressed:(id)sender;

@end
