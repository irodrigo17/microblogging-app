//
//  IRLike.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import "IRLike.h"

#define IRLikeResourceURL @"like/"

@implementation IRLike

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if(self){
        self.user = [dictionary valueForKey:IRUserFieldKey];
        self.post = [dictionary valueForKey:IRPostFieldKey];
    }
    return self;
}

- (id)initWithPost:(NSString *)post user:(NSString *)user
{
    self = [super init];
    if(self){
        self.user = user;
        self.post = post;
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.user forKey:IRUserFieldKey];
    [dic setValue:self.post forKey:IRPostFieldKey];
    return dic;
}

+ (NSString*)resourcePath
{
    return IRLikeResourceURL;
}

@end
