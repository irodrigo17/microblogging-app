//
//  NSDictionary+NoNSNull.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "NSDictionary+NoNSNull.h"

@implementation NSDictionary (NoNSNull)

- (id)valueForKeyNoNSNull:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj isKindOfClass:[NSNull class]] ? nil : obj;
}

@end
