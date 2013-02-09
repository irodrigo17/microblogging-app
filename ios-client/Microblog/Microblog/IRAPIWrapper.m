//
//  IRAPIWrapper.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "IRAPIWrapper.h"
#import "IRFollow.h"
#import "IRPaginatedArray.h"

@implementation IRAPIWrapper

static IRAPIWrapper *_sharedInstance;

+ (IRAPIWrapper*)sharedInstance
{
    if(!_sharedInstance){
        _sharedInstance = [[IRAPIWrapper alloc] init];
    }
    return _sharedInstance;
}

- (void)toggleFollowWithFollower:(IRUser*)follower
                        followee:(IRUser*)followee
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if([followee.followedByCurrentUser boolValue]){
        // find follow instance
        NSDictionary *params = @{@"follower":follower.modelId, @"followee":followee.modelId};
        [[IRMicroblogClient sharedClient] getPath:[IRFollow resourcePath] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            IRPaginatedArray *array = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRFollow class]];
            IRFollow *follow = [array.objects lastObject];
            if(follow){
                // delete follow instance
                [[IRMicroblogClient sharedClient] deletePath:follow.resourceURI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(operation, error);
                }];
            }
            else{
                // follow instance already deleted
                success(operation, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(operation, error);
        }];
    }
    else{
        // create follow instance
        IRFollow *follow = [[IRFollow alloc] initWithFollower:follower.resourceURI followee:followee.resourceURI];
        // post follow instance
        [[IRMicroblogClient sharedClient] postPath:[IRFollow resourcePath] parameters:[follow dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(operation, responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(operation, error);
        }];
    }
}

@end
