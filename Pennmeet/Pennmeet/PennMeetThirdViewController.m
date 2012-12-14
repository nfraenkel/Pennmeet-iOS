//
//  PennMeetThirdViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetThirdViewController.h"

@interface PennMeetThirdViewController ()

@end

@implementation PennMeetThirdViewController

@synthesize plusButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
//    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [plusButton addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// handle method
- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"GENERATE QR CODE SCANNER!!!");
    // TODO: bring up qr code scanner/ camera
    
//    PennMeetRequests *pm = [[PennMeetRequests alloc] init];
//    [pm retrieveUser:@"fraenkel@seas.upenn.edu"];
//    [pm retrieveGroup:@"KoolKidsKlub"];
    
//    NuMongoDB *mongo = [NuMongoDB new];
//	[mongo connectWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:
//							   @"127.0.0.1", @"host", nil]];
//    
//	NSString *collection = @"test.sample";
//    
//	[mongo dropCollection:@"sample" inDatabase:@"test"];
//    
//	id sample = [NSDictionary dictionaryWithObjectsAndKeys:
//				 [NSNumber numberWithInt:1], @"one",
//				 [NSNumber numberWithDouble:2.0], @"two",
//				 @"3", @"three",
//				 [NSArray arrayWithObjects:@"zero", @"one", @"two", @"three", nil], @"four",
//				 nil];
//	[mongo insertObject:sample intoCollection:collection];
//    
//	id first = [mongo findOne:nil inCollection:collection];
//	NSLog(@"%@", first);
}


@end
