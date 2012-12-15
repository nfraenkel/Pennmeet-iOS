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
    NSLog(@"current user has %d groups", self.currentUser.currentUser.groupsSimplified.count);
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewdidappear");
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

- (IBAction)refresherTouched:(id)sender {
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentUser.currentUser.groupsSimplified.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    PennMeetSimplifiedGroup *sGroup = _currentUser.currentUser.groupsSimplified[indexPath.row];
    cell.textLabel.text = sGroup.name;
    if ([sGroup.admin isEqualToString:@"YES"])
        cell.detailTextLabel.text = @"Admin";
    else
        cell.detailTextLabel.text = @"";
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showGroup"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PennMeetSimplifiedGroup *g = self.currentUser.currentUser.groupsSimplified[indexPath.row];
        [[segue destinationViewController] setGroupItem:g.identifier];
    }
}

-(void)populateTableWithCurrentUsersGroups {
    [self.tableView reloadData];
}
@end
