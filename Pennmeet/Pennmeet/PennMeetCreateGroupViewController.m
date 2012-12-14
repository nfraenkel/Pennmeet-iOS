//
//  PennMeetCreateGroupViewController.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetCreateGroupViewController.h"

@interface PennMeetCreateGroupViewController ()

@end

@implementation PennMeetCreateGroupViewController

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

- (IBAction)cancelButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"CANCELLED GROUP CREATION");
    }];
}

- (IBAction)doneButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"DONE WITH GROUP CREATION");
    }];
    
}
@end
