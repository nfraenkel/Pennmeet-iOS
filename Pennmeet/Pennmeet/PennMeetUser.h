//
//  PennMeetUser.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PennMeetUser : NSObject

@property (nonatomic) NSString *uniqueID, *first, *last, *school, *major, *birthday;
@property (nonatomic, retain) NSMutableArray *groupsSimplified;

-(id)initWithId:(NSString *)newID andFirst:(NSString *)newFirst andLast:(NSString *)newLast andSchool:(NSString *)newSchool andMajor:(NSString *)newMajor andBirthday:(NSString *)newBirthday andGroups:(NSMutableArray *)newGroups;

@end
