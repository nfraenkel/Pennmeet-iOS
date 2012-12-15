//
//  PennMeetGroup.m
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "PennMeetGroup.h"

@implementation PennMeetGroup

@synthesize name, photoUrl, memberIDs;

-(id)initWithName:(NSString *)newID andPhotoUrl:(NSString *)url andMemberIDArray:(NSMutableArray *)array andMemberNamesArray:(NSMutableArray *)array2{
    
    self = [super init];
    if (self) {
        self.name = newID;
        self.photoUrl = url;
        self.memberIDs = array;
        self.memberNames = array2;
        return self;
    }
    
    return nil;
}


@end
