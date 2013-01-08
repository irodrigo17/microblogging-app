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

@synthesize modelId = _modelId;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self){
        self.modelId = [dictionary valueForKey:IRIdFieldKey];
        
        // get dates
        NSString *createdAt = [dictionary valueForKey:IRCreatedAtFieldKey];
        ISO8601DateFormatter *df = [IRDateFormatterCache sharedISO8601DateFormatter];
        if(createdAt){
            self.createdAt = [df dateFromString:createdAt];
        }
        NSString *updatedAt = [dictionary valueForKey:IRUpdatedAtFieldKey];
        if(updatedAt){
            self.updatedAt = [df dateFromString:updatedAt];
        }        
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.modelId forKey:IRIdFieldKey];
    ISO8601DateFormatter *df = [IRDateFormatterCache sharedISO8601DateFormatter];
    [dic setValue:[df stringFromDate:self.createdAt] forKey:IRCreatedAtFieldKey];
    [dic setValue:[df stringFromDate:self.updatedAt] forKey:IRUpdatedAtFieldKey];
    return dic;
}


@end
