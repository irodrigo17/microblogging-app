//
//  NSDictionary+NoNSNull.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NoNSNull)

- (id)valueForKeyNoNSNull:(NSString *)key;

@end
