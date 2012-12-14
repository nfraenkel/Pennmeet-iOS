//
//  PennMeetGroup.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PennMeetGroup : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *memberIDs;

-(id)initWithName:(NSString *)newID andArray:(NSMutableArray *)array;


@end
