//
//  IRFollow.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/20/13.
//
//

#import "IRModel.h"

#define IRFollowResourceURL @"follow/"

#define IRFollowerFieldKey @"follower"
#define IRFolloweeFieldKey @"followee"

@interface IRFollow : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *follower;
@property (strong, nonatomic) NSString *followee;

- (id)initWithFollower:(NSString*)follower followee:(NSString*)followee;

@end
