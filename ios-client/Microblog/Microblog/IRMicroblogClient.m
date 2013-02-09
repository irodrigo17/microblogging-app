//
//  IRMicroblogClient.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRMicroblogClient.h"
#import "AFHTTPRequestOperation.h"

#define IRAuthorizationHeaderKey @"Authorization"

@interface IRMicroblogClient ()

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *APIKey;

@end

@implementation IRMicroblogClient

static IRMicroblogClient *_sharedClient = nil;

+ (IRMicroblogClient*)sharedClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[IRMicroblogClient alloc] initWithBaseURL:[NSURL URLWithString:IRBaseURLDev]];
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

- (void)setUsername:(NSString*)username APIKey:(NSString*)APIKey
{
    self.username = username;
    self.APIKey = APIKey;
    [self setDefaultHeader:IRAuthorizationHeaderKey
                     value:[NSString stringWithFormat:@"ApiKey %@:%@",username,APIKey]];
}

- (void)logout
{
    self.user = nil;
    [self setDefaultHeader:IRAuthorizationHeaderKey value:nil];
}

- (void)updateBaseURL:(NSString*)baseURL
{
    _sharedClient = [[IRMicroblogClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
}

@end
