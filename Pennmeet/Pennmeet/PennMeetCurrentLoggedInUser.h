//
//  PennMeetCurrentLoggedInUser.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PennMeetUser.h"

@interface PennMeetCurrentLoggedInUser : NSObject {
    PennMeetUser *currentUser;
    
}

@property (nonatomic, retain) PennMeetUser *currentUser;


+ (PennMeetCurrentLoggedInUser *) sharedDataModel;

@end