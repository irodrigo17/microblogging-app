//
//  IRMicroblogClient.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "IRHTTPStatusCodes.h"
#import "IRUser.h"

#define IRGETHTTPMethod @"GET"
#define IRPOSTHTTPMethod @"POST"
#define IRPUTHTTPMethod @"PUT"
#define IRPATCHHTTPMethod @"PATCH"
#define IRDELETEHTTPMethod @"DELETE"

#define IRBaseURLProd @"http://microblog-ir.herokuapp.com/api/v1/"
#define IRBaseURLDev @"http://localhost:5000/api/v1/"

@interface IRMicroblogClient : AFHTTPClient

@property (strong, nonatomic) IRUser *user; // the signed in user

+ (IRMicroblogClient*)sharedClient;

/**
 * Sets the username and API key that will be appended to each request for authentication purposes.
 */
- (void)setUsername:(NSString*)username APIKey:(NSString*)APIKey;

/**
 * Clears authentication parameters (username and APIKey) and user.
 */
- (void)logout;

- (void)updateBaseURL:(NSString*)baseURL;

@end
