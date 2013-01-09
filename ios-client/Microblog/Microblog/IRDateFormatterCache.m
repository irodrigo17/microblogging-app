//
//  IRDateFormatterCache.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRDateFormatterCache.h"

@implementation IRDateFormatterCache

static ISO8601DateFormatter* sharedISO8601DateFormatter;
static NSDateFormatter *sharedDateFormatter;

+ (ISO8601DateFormatter*)sharedISO8601DateFormatter
{
    if(!sharedISO8601DateFormatter){
        sharedISO8601DateFormatter = [[ISO8601DateFormatter alloc] init];
        sharedISO8601DateFormatter.includeTime = YES;
    }
    return sharedISO8601DateFormatter;
}

+ (NSDateFormatter*)sharedDateFormatter
{
    if(!sharedDateFormatter){
        sharedDateFormatter = [[NSDateFormatter alloc] init];
        sharedDateFormatter.dateStyle = NSDateFormatterLongStyle;
        sharedDateFormatter.timeStyle = NSDateFormatterMediumStyle;
    }
    return sharedDateFormatter;
}

@end
