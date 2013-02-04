//
//  IRMessage.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRSearchableModel.h"

#define IRTextFieldKey @"text"
#define IRCreatedDateFieldKey @"created_date"
#define IRInReplyToFieldKey @"in_reply_to"
#define IRLikesFieldKey @"likes"
#define IRModifiedDateFieldKey @"modified_date"
#define IRRepliesFieldKey @"replies"
#define IRSharesFieldKey @"shares"
#define IRUserFieldKey @"user"
#define IRLikedByCurrentUserFieldKey @"liked_by_current_user"
#define IRSharedByCurrentUserFieldKey @"shared_by_current_user"


@class IRUser;


@interface IRPost : IRSearchableModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *text; // Max 200 chars.
@property (strong, nonatomic) NSString *userURI; // The resource URI of the user, used for posting
@property (strong, nonatomic) IRUser *user; // The full user
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSDate *modifiedDate;
@property (strong, nonatomic) NSString *inReplyTo; // Optional.
@property (strong, nonatomic) NSNumber *replies;
@property (strong, nonatomic) NSNumber *shares;
@property (strong, nonatomic) NSNumber *likes;
@property (strong, nonatomic) NSNumber *likedByCurrentUser;
@property (strong, nonatomic) NSNumber *sharedByCurrentUser;

- (id)initWithText:(NSString*)text
              user:(NSString*)userURI;

+ (NSString*)feedResourcePath;
+ (NSString*)feedResourceSearchPath;

@end
