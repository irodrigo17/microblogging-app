//
//  IRLike.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import "IRModel.h"

#define IRUserFieldKey @"user"
#define IRPostFieldKey @"post"

@interface IRLike : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *post;

- (id)initWithPost:(NSString*)post user:(NSString*)user;

@end
