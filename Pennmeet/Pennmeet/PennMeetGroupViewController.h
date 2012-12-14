//
//  PennMeetGroupViewController.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PennMeetGroup.h"
#import "PennMeetAppDelegate.h"

@interface PennMeetGroupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    NSMutableData *_data;
}


@property (strong, nonatomic) NSString *groupID;
@property (strong, nonatomic) PennMeetGroup *group;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UITableView *tableForGroupMembers;
@property (weak, nonatomic) IBOutlet UIImageView *groupCoverPhotoTho;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refesher;


-(void)setGroupItem:(NSString *)newGroup;


- (IBAction)refresherPressed:(id)sender;

@end
