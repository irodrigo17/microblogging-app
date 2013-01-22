//
//  IRShare.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/22/13.
//
//

#import "IRModel.h"

#define IRShareResourceURL @"share/"

#define IRUserFieldKey @"user"
#define IRPostFieldKey @"post"

@interface IRShare : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *post;

- (id)initWithPost:(NSString*)post user:(NSString*)user;

@end
