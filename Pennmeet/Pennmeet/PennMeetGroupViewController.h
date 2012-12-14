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

@interface PennMeetGroupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableData *_data;
}


@property (strong, nonatomic) NSString *groupID;
@property (strong, nonatomic) PennMeetGroup *group;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UITableView *tableForGroupMembers;


-(void)setGroupItem:(NSString *)newGroup;

@end
