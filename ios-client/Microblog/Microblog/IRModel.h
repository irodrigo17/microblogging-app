//
//  IRModel.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"
#import "NSDictionary+NoNSNull.h"

#define IRIdFieldKey @"id"
#define IRResourceURIFieldKey @"resource_uri"

@interface IRModel : NSObject <IRDictianaryRepresentation>

@property (strong, nonatomic) NSNumber *modelId;
@property (strong, nonatomic) NSString *resourceURI;

+ (NSNumber*)idFromResourceURI:(NSString*)resourceURI;

/**
 * This method should be overriden by subclasses.
 */
+ (NSString*)resourcePath;

@end
