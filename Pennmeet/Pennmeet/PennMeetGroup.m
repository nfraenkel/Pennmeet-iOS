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

-(id)initWithName:(NSString *)newID andPhotoUrl:(NSString *)url andArray:(NSMutableArray *)array{
    self = [super init];
    if (self) {
        self.name = newID;
        self.photoUrl = url;
        self.memberIDs = array;
        return self;
    }
    
    return nil;
}


@end
