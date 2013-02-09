//
//  IRUser.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"
#import "IRSearchableModel.h"

#define IRFirstNameFieldKey @"first_name"
#define IRLastNameFieldKey @"last_name"
#define IREmailFieldKey @"email"
#define IRUsernameFieldKey @"username"
#define IRPasswordFieldKey @"password"
#define IRFollowersFieldKey @"followers_count"
#define IRFollowingFieldKey @"following_count"
#define IRFollowedByCurrentUserFieldKey @"followed_by_current_user"
#define IRPostsCountFieldKey @"posts_count"
#define IRAvatarURLFieldKey @"avatar_url"


@interface IRUser : IRSearchableModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSNumber *following;
@property (strong, nonatomic) NSNumber *followers;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSNumber *followedByCurrentUser;
@property (strong, nonatomic) NSNumber *postsCount;
@property (strong, nonatomic) NSString *avatarURL;

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString *)username
                  email:(NSString *)email
               password:(NSString *)password;

- (NSString*)followersURI;
- (NSString*)followingURI;

- (NSString*)fullName;

@end
