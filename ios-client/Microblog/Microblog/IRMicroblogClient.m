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
        _sharedClient = [[IRMicroblogClient alloc] initWithBaseURL:[NSURL URLWithString:IRBaseURLProd]];
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

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self requestWithMethod:method path:path parameters:parameters addAuthQueryParams:YES];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters addAuthQueryParams:(BOOL)addAuthQueryParams
{
#warning Refactor to use super
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    if(addAuthQueryParams && self.username && self.APIKey){
        NSDictionary *authParams = @{@"username":self.username, @"api_key":self.APIKey};
        NSString *oldURLString = [request.URL absoluteString];
        BOOL hasQuery = [oldURLString rangeOfString:@"?"].location != NSNotFound;
        NSString *format = hasQuery ? @"&%@" : @"?%@";
        NSString *newURLString = [oldURLString stringByAppendingFormat:format, AFQueryStringFromParametersWithEncoding(authParams, self.stringEncoding)];
        request.URL = [NSURL URLWithString:newURLString];
    }
    return request;
}

- (void)updateBaseURL:(NSString*)baseURL
{
    _sharedClient = [[IRMicroblogClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
}

@end
