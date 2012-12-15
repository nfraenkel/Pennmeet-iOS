//
//  PennMeetGroup.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetGroup.h"

@implementation PennMeetGroup

@synthesize identifier, name, photoUrl, memberIDs, memberNames;

-(id)initWithID:(NSString *)newID andName:(NSString *)newName andPhotoUrl:(NSString *)url andMemberIDArray:(NSMutableArray *)array andMemberNamesArray:(NSMutableArray *)array2{

    self = [super init];
    if (self) {
        self.identifier = newID;
        self.name = newName;
        self.photoUrl = url;
        self.memberIDs = array;
        self.memberNames = array2;
        return self;
    }
    
    return nil;
}


@end
