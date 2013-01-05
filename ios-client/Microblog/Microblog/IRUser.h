//
//  IRUser.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRUser : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *name;

@end
