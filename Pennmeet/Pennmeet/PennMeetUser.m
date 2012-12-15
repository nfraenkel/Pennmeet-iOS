//
//  PennMeetUser.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetUser.h"

@implementation PennMeetUser

@synthesize uniqueID, first, last, school, major, birthday;

-(id)initWithId:(NSString *)newID andFirst:(NSString *)newFirst andLast:(NSString *)newLast andSchool:(NSString *)newSchool andMajor:(NSString *)newMajor andBirthday:(NSString *)newBirthday andGroups:(NSMutableArray *)newGroups andAdminBools:(NSMutableArray *)admins{
    self = [super init];
    if (self) {
        self.uniqueID = newID;
        self.first = newFirst;
        self.last = newLast;
        self.school = newSchool;
        self.major = newMajor;
        self.birthday = newBirthday;
        self.groupIDs = newGroups;
        self.groupAdminBools = admins;
        return self;
    }
    
    return nil;
}

@end
