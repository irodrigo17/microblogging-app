//
//  AFHTTPRequestOperation+IRUtils.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "AFHTTPRequestOperation.h"

@interface AFHTTPRequestOperation (IRUtils)

/**
 * Checks if the request failed with an standard error.
 * Standard errors:
 * - Connection issues
 * - Authentication error (401)
 */
- (BOOL)failedWithStandardError;

/**
 * Returns the standard error message if the request failed with an standard error.
 */
- (NSString*)standardErrorMessage;

@end
