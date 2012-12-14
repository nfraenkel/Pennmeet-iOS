//
//  PennMeetSecondViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetSecondViewController.h"

@interface PennMeetSecondViewController ()

@end

@implementation PennMeetSecondViewController

- (void)viewDidLoad
{
    NSLog(@"my groups VIEWDIDLOAD");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.currentUser = [PennMeetCurrentLoggedInUser sharedDataModel];
    NSLog(@"current user has %d groups", self.currentUser.currentUser.groupIDs.count);
    
    [self populateTableWithCurrentUsersGroups];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newGroupTouched:(id)sender {
    
    NSLog(@"NEW GROUP TOUCHED THO");
//    [self performSegueWithIdentifier:@"createNewGroup" sender:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentUser.currentUser.groupIDs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    NSString* groupID = _currentUser.currentUser.groupIDs[indexPath.row];
    cell.textLabel.text = groupID;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showGroup"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *groupID = self.currentUser.currentUser.groupIDs[indexPath.row];
        [[segue destinationViewController] setGroupItem:groupID];
    }
}

-(void)populateTableWithCurrentUsersGroups {
    [self.tableView reloadData];
}
@end
