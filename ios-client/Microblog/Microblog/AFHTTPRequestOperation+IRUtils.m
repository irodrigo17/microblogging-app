//
//  AFHTTPRequestOperation+IRUtils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "AFHTTPRequestOperation+IRUtils.h"
#import "NSError+IRAPIClientUtils.h"


@implementation AFHTTPRequestOperation (IRUtils)


- (BOOL)failedWithStandardError
{
    return ((self.error && [self.error isConnectionError]) || self.response.statusCode == 401);
}

- (NSString*)standardErrorMessage
{
    if(self.error && [self.error isConnectionError]){
        return @"Can't connect with server, please check your internet connection.";
    }
    else if(self.response.statusCode == 401){
        return @"You're not authorized to perform this action.";
    }
    else{
        return nil;
    }
}

@end
