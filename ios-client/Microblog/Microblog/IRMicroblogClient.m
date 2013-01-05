//
//  IRMicroblogClient.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRMicroblogClient.h"
#import "AFJSONRequestOperation.h"


@implementation IRMicroblogClient

static NSString * const IRMicroblogBaseURLString = @"http://localhost:3000/";

+ (IRMicroblogClient*)sharedClient{
    static IRMicroblogClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[IRMicroblogClient alloc] initWithBaseURL:[NSURL URLWithString:IRMicroblogBaseURLString]];
    });    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
