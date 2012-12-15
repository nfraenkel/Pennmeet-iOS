//
//  PennMeetSimplifiedGroup.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/15/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PennMeetSimplifiedGroup : NSObject

@property (nonatomic) NSString *identifier, *name, *admin;


-(id)initWithID:(NSString *)newID andName:(NSString *)newName andAdmin:(NSString *)newAdmin;



@end
