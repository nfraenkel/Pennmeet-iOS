//
//  PennMeetRequests.h
//  PennMeet
//
//  Created by Nathan Fraenkel on 12/13/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PennMeetUser.h"

@interface PennMeetRequests : NSObject <NSURLConnectionDataDelegate> {

    NSMutableData *_data;
}

-(void)retrieveUser:(NSString *)identifier;

@end
