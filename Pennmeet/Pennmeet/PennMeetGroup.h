//
//  PennMeetGroup.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/14/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PennMeetGroup : NSObject

@property (nonatomic) NSString *identifier, *name, *photoUrl;
@property (nonatomic) NSMutableArray *memberIDs, *memberNames;


-(id)initWithID:(NSString *)newID andName:(NSString *)newName andPhotoUrl:(NSString *)url andMemberIDArray:(NSMutableArray *)array andMemberNamesArray:(NSMutableArray *)array2;


@end
