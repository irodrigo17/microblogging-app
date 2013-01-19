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

@property (strong, nonatomic) NSString *APIKey;
@property (strong, nonatomic) IRUser *user; // the signed in user

+ (IRMicroblogClient*)sharedClient;

@end
