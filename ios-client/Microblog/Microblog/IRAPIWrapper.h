//
//  IRAPIWrapper.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import <Foundation/Foundation.h>
#import "IRMicroblogClient.h"

@interface IRAPIWrapper : NSObject

+ (IRAPIWrapper*)sharedInstance;

/**
 * Makes follower follow/stop following followee.
 */
- (void)toggleFollowWithFollower:(IRUser*)follower
                        followee:(IRUser*)followee
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
