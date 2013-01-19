//
//  IRMessage.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRModel.h"

#define IRTextFieldKey @"text"
#define IRCreatedDateFieldKey @"created_date"
#define IRInReplyToFieldKey @"in_reply_to"
#define IRLikesFieldKey @"likes"
#define IRModifiedDateFieldKey @"modified_date"
#define IRRepliesFieldKey @"replies"
#define IRSharesFieldKey @"shares"
#define IRUserFieldKey @"user"

#define IRPostResourceURL @"post/"

@interface IRPost : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *text; // Max 200 chars.
@property (strong, nonatomic) NSString *user; // The resource URI of the user.
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSDate *modifiedDate;
@property (strong, nonatomic) NSString *inReplyTo; // Optional.
@property (strong, nonatomic) NSNumber *replies;
@property (strong, nonatomic) NSNumber *shares;
@property (strong, nonatomic) NSNumber *likes;

- (id)initWithText:(NSString*)text
              user:(NSString*)user;

@end
