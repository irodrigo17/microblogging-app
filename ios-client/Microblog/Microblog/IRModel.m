//
//  IRModel.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRModel.h"
#import "IRDateFormatterCache.h"

@implementation IRModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self){
        self.modelId = [dictionary valueForKey:IRIdFieldKey];
        self.resourceURI = [dictionary valueForKey:IRResourceURIFieldKey];
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

- (id)NSNullToNil:(id)object
{
    return ([object isKindOfClass:[NSNull class]]) ? nil : object;
}

+ (NSNumber*)idFromResourceURI:(NSString*)resourceURI
{
    NSURL *URL = [NSURL URLWithString:resourceURI];
    return [URL.pathComponents lastObject];
}

@end
