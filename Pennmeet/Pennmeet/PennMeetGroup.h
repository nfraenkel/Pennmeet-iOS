//
//  PennMeetGroup.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PennMeetGroup : NSObject

@property (nonatomic) NSString *name, *photoUrl;
@property (nonatomic) NSMutableArray *memberIDs;

-(id)initWithName:(NSString *)newID andPhotoUrl:(NSString *)url andArray:(NSMutableArray *)array;


@end
