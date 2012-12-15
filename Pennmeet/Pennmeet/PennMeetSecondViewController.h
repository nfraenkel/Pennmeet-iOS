//
//  PennMeetSecondViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetCurrentLoggedInUser.h"
#import "PennMeetGroupViewController.h"
#import "PennMeetSimplifiedGroup.h"


@interface PennMeetSecondViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)newGroupTouched:(id)sender;

@property (retain) PennMeetCurrentLoggedInUser *currentUser;

@property (weak, nonatomic) IBOutlet UILabel *title;


@end
