//
//  IRDateFormatterCache.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISO8601DateFormatter.h"

@interface IRDateFormatterCache : NSObject

+ (ISO8601DateFormatter*)sharedISO8601DateFormatter;

+ (NSDateFormatter*)sharedDateFormatter;

@end
