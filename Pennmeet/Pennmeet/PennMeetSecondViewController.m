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
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
@end
