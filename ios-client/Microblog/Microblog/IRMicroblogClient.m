//
//  IRMicroblogClient.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRMicroblogClient.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@implementation IRMicroblogClient

static NSString * const IRMicroblogBaseURLString = @"http://localhost:3000/";

@synthesize user = _user;

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
    
    // register AFJSONRequestOperation
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];    
    // set default headers
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];    
    // set parameter encoding
    self.parameterEncoding = AFJSONParameterEncoding;
    
    return self;
}

@end
