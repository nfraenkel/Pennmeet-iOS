//
//  PennMeetSimplifiedGroup.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/15/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetSimplifiedGroup.h"

@implementation PennMeetSimplifiedGroup

@synthesize identifier, name, admin;

-(id)initWithID:(NSString *)newID andName:(NSString *)newName andAdmin:(NSString *)newAdmin{

    self = [super init];
    if (self) {
        self.identifier = newID;
        self.name = newName;
        self.admin = newAdmin;
        return self;
    }
    
    return nil;
    
}


@end
