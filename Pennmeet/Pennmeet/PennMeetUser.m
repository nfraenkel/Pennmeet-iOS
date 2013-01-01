//
//  PennMeetUser.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetUser.h"

@implementation PennMeetUser

@synthesize uniqueID, first, last, school, major, birthday, fbID, groupsSimplified;

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
        self.uniqueID = [user objectForKey:@"email"];
        self.first = user.first_name;
        self.last = user.last_name;
        self.birthday = user.birthday;
        self.fbID = user.id;
        return self;
    }
    
    return nil;
}
@end
