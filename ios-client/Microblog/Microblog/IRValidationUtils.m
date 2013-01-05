//
//  IRValidationUtils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRValidationUtils.h"

@implementation IRValidationUtils

+ (BOOL)isValidEmail:(NSString*)email
{
    NSString *emailRegex = @".+@.+\\.[A-Za-z]{2,}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}

@end
