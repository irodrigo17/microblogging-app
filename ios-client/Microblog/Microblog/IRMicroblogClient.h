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

@interface IRMicroblogClient : AFHTTPClient

+ (IRMicroblogClient*)sharedClient;

@end
