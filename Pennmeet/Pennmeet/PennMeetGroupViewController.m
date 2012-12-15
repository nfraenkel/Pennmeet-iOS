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

NSString* groupImageUrl = @"http://3.bp.blogspot.com/-h_utGfKAS_4/T4dEB40eGVI/AAAAAAAAAH4/v7O7t0l26Cw/s1600/the-cool-kids-2.jpg";

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
        self.navItem.title = groupID;
        
        // get group info from DB
        [self retrieveGroup:groupID];
    }
}

- (IBAction)refresherPressed:(id)sender {
    
    [self retrieveGroup:groupID];
}

-(void)configureView {
    // call helper - get image from url
    UIImage* cvtho = [self imageFromURLString:self.group.photoUrl];
    
    // set group cover photo
    [self.groupCoverPhotoTho setImage:cvtho];

    // add swipe gesture recognizer to go back
    // TODO: FIX IT DOESNT WORK - doesnt get recognized on ios simulator?
    UISwipeGestureRecognizer *rec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipOnImage:)];
    rec.direction = UISwipeGestureRecognizerDirectionRight;
    [rec setNumberOfTouchesRequired:1];
    [self.groupCoverPhotoTho addGestureRecognizer:rec];
    
    // refresh dat table
    [self.tableForGroupMembers reloadData];
    
}

- (void)leftSwipOnImage:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSLog(@"SWIPING");
    [[self navigationController] popViewControllerAnimated:YES];
    
}


// HELPER - returns image from url. so sexy
- (UIImage *)imageFromURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    [request release];
//    [self handleError:error];
    UIImage *resultImage = [UIImage imageWithData:(NSData *)result];
    
    NSLog(@"urlString: %@",urlString);
    return resultImage;
}

+ (UIImage *)imageResize:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)retrieveGroup:(NSString *)identifier{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // TODO: FIGURE OUT HOW TO ENCODE URL
//    NSString *encoded = [identifier stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encoded = identifier;
    
    NSString *url = [NSString stringWithFormat:@"https://api.mongohq.com/databases/pmeet/collections/groups/documents/%@?_apikey=%@", encoded, [(PennMeetAppDelegate*)[[UIApplication sharedApplication] delegate] apiToken]];
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
    NSString *memberName = self.group.memberNames[indexPath.row];
    cell.textLabel.text = memberName;
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
                          initWithTitle: @"Error: group"
                          message: @"There was a network error while retrieving group info."
                          delegate: self
                          cancelButtonTitle:@"OK BYE"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        // CANCEL
    }
    else if (buttonIndex == 1) {
        // RETRY
        [self retrieveGroup:groupID];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    if (dictResponse.count == 3){ // retrieveGroup
        NSMutableArray* mems = [NSMutableArray array];
        NSMutableArray* memNames = [NSMutableArray array];
        NSString* identy = [dictResponse objectForKey:@"_id"];
        NSString* url = [dictResponse objectForKey:@"photoUrl"];
        NSDictionary *membersDict = [dictResponse objectForKey:@"members"];
        for (int i = 1; i <= (membersDict.count / 2); i++){
            NSString* memb = [membersDict objectForKey:[NSString stringWithFormat:@"id%d", i]];
            [mems addObject:memb];
            NSString* memName = [membersDict objectForKey:[NSString stringWithFormat:@"name%d", i]];
            [memNames addObject:memName];
        }
        self.group = [[PennMeetGroup alloc] initWithName:identy andPhotoUrl:url andMemberIDArray:mems andMemberNamesArray:memNames];

        
        [self configureView];
    }
}


@end
