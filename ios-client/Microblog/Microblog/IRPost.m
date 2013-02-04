//
//  IRMessage.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPost.h"
#import "IRDateFormatterCache.h"
#import "IRUser.h"

#define IRPostResourceURL @"post/"
#define IRFeedResourceURL @"feed/"

@implementation IRPost

@synthesize text = _text;

- (id)initWithText:(NSString*)text
              user:(NSString*)userURI
{
    self = [super init];
    if(self){
        self.text = text;
        self.userURI = userURI;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if(self){
        self.text = [dictionary valueForKey:IRTextFieldKey];
        NSDictionary *userDic = [dictionary valueForKey:IRUserFieldKey];
        self.user = [[IRUser alloc] initWithDictionary:userDic];
        self.inReplyTo = [self NSNullToNil:[dictionary valueForKey:IRInReplyToFieldKey]];
        self.shares = [dictionary valueForKey:IRSharesFieldKey];
        self.likes = [dictionary valueForKey:IRLikesFieldKey];
        self.replies = [dictionary valueForKey:IRRepliesFieldKey];
        self.likedByCurrentUser = [dictionary valueForKey:IRLikedByCurrentUserFieldKey];
        self.sharedByCurrentUser = [dictionary valueForKey:IRSharedByCurrentUserFieldKey];
        // get dates
        NSString *createdDate = [dictionary valueForKey:IRCreatedDateFieldKey];
        ISO8601DateFormatter *df = [IRDateFormatterCache sharedISO8601DateFormatter];
        if(createdDate){
            self.createdDate = [df dateFromString:createdDate];
        }
        NSString *modifiedDate = [dictionary valueForKey:IRModifiedDateFieldKey];
        if(modifiedDate){
            self.modifiedDate = [df dateFromString:modifiedDate];
        }
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.text forKey:IRTextFieldKey];
    if(self.userURI){
        [dic setValue:self.userURI forKey:IRUserFieldKey];
    }
    else if(self.user){
        [dic setValue:self.user.resourceURI forKey:IRUserFieldKey];
    }
    [dic setValue:self.inReplyTo forKey:IRInReplyToFieldKey];
    return dic;
}

+ (NSString*)resourcePath
{
    return IRPostResourceURL;
}

+ (NSString*)feedResourcePath
{
    return IRFeedResourceURL;
}

+ (NSString*)feedResourceSearchPath
{
    return [self searchPathWithBasePath:[self feedResourcePath]];
}

@end
