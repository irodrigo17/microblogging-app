//
//  IRFollow.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/20/13.
//
//

#import "IRFollow.h"

#define IRFollowResourceURL @"follow/"

@implementation IRFollow

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if(self){
        self.followee = [dictionary valueForKey:IRFolloweeFieldKey];
        self.follower = [dictionary valueForKey:IRFollowerFieldKey];
    }
    return self;
}

- (id)initWithFollower:(NSString*)follower followee:(NSString*)followee;
{
    self = [super init];
    if(self){
        self.follower = follower;
        self.followee = followee;
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.follower forKey:IRFollowerFieldKey];
    [dic setValue:self.followee forKey:IRFolloweeFieldKey];
    return dic;
}

+ (NSString*)resourcePath
{
    return IRFollowResourceURL;
}

@end
