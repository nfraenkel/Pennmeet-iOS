//
//  PennMeetEditProfileViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/15/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetEditProfileViewController.h"

@interface PennMeetEditProfileViewController ()

@end

@implementation PennMeetEditProfileViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"EDITING PROFILE CANCELLED THO");
    }];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"EDITING PROFILE SAVED THO");
    }];
}

@end
