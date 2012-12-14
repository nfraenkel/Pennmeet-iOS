//
//  PennMeetCurrentLoggedInUser.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

/* SINGLETON CLASS TO REPRESENT LOGGED IN USER YA HEAAARRRDDDDDDD */

#import "PennMeetCurrentLoggedInUser.h"

@implementation PennMeetCurrentLoggedInUser

@synthesize currentUser;

static PennMeetCurrentLoggedInUser *sharedDataModel = nil;

+ (PennMeetCurrentLoggedInUser *) sharedDataModel {
    @synchronized(self){
        if (sharedDataModel == nil){
            sharedDataModel = [[PennMeetCurrentLoggedInUser alloc] init];
        }
    }
    return sharedDataModel;
}

@end