//
//  IRModel.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRModel.h"
#import "IRDateFormatterCache.h"

#define IRIdField @"id"
#define IRCreatedAtField @"created_at"
#define IRUpdatedAtField @"updated_at"

@implementation IRModel

@synthesize modelId = _modelId;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self){
        self.modelId = [dictionary valueForKey:IRIdField];
        
        // get dates
        NSString *createdAt = [dictionary valueForKey:IRCreatedAtField];
        ISO8601DateFormatter *df = [IRDateFormatterCache sharedISO8601DateFormatter];
        if(createdAt){
            self.createdAt = [df dateFromString:createdAt];
        }
        NSString *updatedAt = [dictionary valueForKey:IRUpdatedAtField];
        if(updatedAt){
            self.updatedAt = [df dateFromString:updatedAt];
        }        
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.modelId forKey:IRIdField];
    [dic setValue:[[IRDateFormatterCache sharedISO8601DateFormatter] stringFromDate:self.createdAt] forKey:IRCreatedAtField];
    [dic setValue:[[IRDateFormatterCache sharedISO8601DateFormatter] stringFromDate:self.updatedAt] forKey:IRUpdatedAtField];
    return dic;
}


@end
