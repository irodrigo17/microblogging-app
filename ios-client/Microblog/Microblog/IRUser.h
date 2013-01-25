//
//  IRUser.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"
#import "IRModel.h"

#define IRFirstNameFieldKey @"first_name"
#define IRLastNameFieldKey @"last_name"
#define IREmailFieldKey @"email"
#define IRUsernameFieldKey @"username"
#define IRPasswordFieldKey @"password"
#define IRFollowersFieldKey @"followers"
#define IRFollowingFieldKey @"following"
#define IRFollowedByCurrentUserFieldKey @"followed_by_current_user"
#define IRPostsCountFieldKey @"posts_count"

#define IRUserResourceURL @"user/"

@interface IRUser : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSNumber *following;
@property (strong, nonatomic) NSNumber *followers;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSNumber *followedByCurrentUser;
@property (strong, nonatomic) NSNumber *postsCount;

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString*)username
                  email:(NSString *)email
               password:(NSString *)password;

@end
