//
//  PennMeetGroupViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetGroupViewController.h"

@interface PennMeetGroupViewController ()

@end

@implementation PennMeetGroupViewController

@synthesize groupID, group;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)setGroupItem:(NSString *)newGroup
{
    if (groupID != newGroup) {
        groupID = newGroup;
        
        // set title of navbar item
        // TODO: uncomment?
//        self.navItem.title = groupID;
        
        // get group info from DB
        [self retrieveGroup:groupID];
    }
}

-(void)configureView {
    
    self.groupName.text = group.name;
    
    [self.tableForGroupMembers reloadData];
    
}

-(void)retrieveGroup:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/groups/documents/%@?_apikey=%@", identifier, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
    
    NSString *memberID = self.group.memberIDs[indexPath.row];
    cell.textLabel.text = memberID;
    cell.detailTextLabel.text = memberID;

    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.group.memberIDs.count;
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"conection did receive response!");
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"conection did receive data!");
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Please do something sensible here, like log the error.
    NSLog(@"connection failed with error: %@", error.description);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error with your request"
                          message: @"There was an error with your request."
                          delegate: self
                          cancelButtonTitle:@"OK BYE"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    if (dictResponse.count == 2){ // retrieveGroup
        NSMutableArray* mems = [NSMutableArray array];
        NSString* identy = [dictResponse objectForKey:@"_id"];
        NSDictionary *membersDict = [dictResponse objectForKey:@"members"];
        for (int i = 1; i <= membersDict.count; i++){
            NSString* memb = [membersDict objectForKey:[NSString stringWithFormat:@"id%d", i]];
            [mems addObject:memb];
        }
        self.group = [[PennMeetGroup alloc] initWithName:identy andArray:mems];

        
        [self configureView];
    }
}


@end
