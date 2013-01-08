//
//  IRModel.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"

#define IRIdFieldKey @"id"
#define IRCreatedAtFieldKey @"created_at"
#define IRUpdatedAtFieldKey @"updated_at"

@interface IRModel : NSObject <IRDictianaryRepresentation>

@property (strong, nonatomic) NSNumber *modelId;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;

@end
