//
//  NSError+IRAPIClientUtils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "NSError+IRAPIClientUtils.h"

@implementation NSError (IRAPIClientUtils)

- (BOOL)isConnectionError
{
    return self.code == NSURLErrorTimedOut ||
        self.code == NSURLErrorCannotFindHost ||
        self.code == NSURLErrorCannotConnectToHost ||
        self.code == NSURLErrorNetworkConnectionLost ||
        self.code == NSURLErrorDNSLookupFailed ||
        self.code == NSURLErrorNotConnectedToInternet;
}

@end
