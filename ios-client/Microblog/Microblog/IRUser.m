//
//  IRUser.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRUser.h"

#define IRUserResourceURL @"user/"
#define IRFollowersNestedResourcePath @"followers/"
#define IRFollowingNestedResourcePath @"following/"

@implementation IRUser

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString*)username
                  email:(NSString *)email
               password:(NSString *)password
{
    self = [super init];
    if(self){
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.password = password;
        self.username = username;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if(self){
        self.firstName = [dictionary valueForKey:IRFirstNameFieldKey];
        self.lastName = [dictionary valueForKey:IRLastNameFieldKey];
        self.email = [dictionary valueForKey:IREmailFieldKey];
        self.username = [dictionary valueForKey:IRUsernameFieldKey];
        self.followers = [dictionary valueForKey:IRFollowersFieldKey];
        self.following = [dictionary valueForKey:IRFollowingFieldKey];
        self.followedByCurrentUser = [self NSNullToNil:[dictionary valueForKey:IRFollowedByCurrentUserFieldKey]];
        self.postsCount = [dictionary valueForKey:IRPostsCountFieldKey];
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.firstName forKey:IRFirstNameFieldKey];
    [dic setValue:self.lastName forKey:IRLastNameFieldKey];
    [dic setValue:self.email forKey:IREmailFieldKey];
    [dic setValue:self.password forKey:IRPasswordFieldKey];
    [dic setValue:self.username forKey:IRUsernameFieldKey];
    [dic setValue:self.avatarURL forKey:IRAvatarURLFieldKey];
    return dic;
}

+ (NSString*)resourcePath
{
    return IRUserResourceURL;
}

- (NSString*)followersURI
{
    return [self.resourceURI stringByAppendingString:IRFollowersNestedResourcePath];
}

- (NSString*)followingURI
{
    return [self.resourceURI stringByAppendingString:IRFollowingNestedResourcePath];
}

@end
