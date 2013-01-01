//
//  PennMeetUser.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetUser.h"

@implementation PennMeetUser

@synthesize uniqueID, first, last, school, major, birthday, groupsSimplified;

-(id)initWithId:(NSString *)newID andFirst:(NSString *)newFirst andLast:(NSString *)newLast andSchool:(NSString *)newSchool andMajor:(NSString *)newMajor andBirthday:(NSString *)newBirthday andGroups:(NSMutableArray *)newGroups{
    self = [super init];
    if (self) {
        self.uniqueID = newID;
        self.first = newFirst;
        self.last = newLast;
        self.school = newSchool;
        self.major = newMajor;
        self.birthday = newBirthday;
        self.groupsSimplified = newGroups;
        return self;
    }
    
    return nil;
}

-(id)initWithFbInfo:(id<FBGraphUser>)user {
    self = [super init];
    if (self) {
        self.fbUser = user;
        self.first = user.name;
        self.last = user.name;
        self.birthday = user.birthday;
        return self;
    }
    
    return nil;
}
@end
