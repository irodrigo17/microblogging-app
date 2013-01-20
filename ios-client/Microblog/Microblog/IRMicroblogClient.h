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

@end
