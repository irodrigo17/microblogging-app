//
//  IRUser.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRUser.h"

@implementation IRUser

@synthesize email = _email;
@synthesize password = _password;
@synthesize name = _name;

- (id)initWithName:(NSString*)name 
             email:(NSString*)email 
          password:(NSString*)password
{
    self = [super init];
    if(self){
        self.name = name;
        self.email = email;
        self.password = password;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
}

- (NSMutableDictionary*)dictionaryRepresentation
{
#warning Field names could be constants
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.name forKey:@"name"];
    [dic setValue:self.email forKey:@"email"];
    [dic setValue:self.password forKey:@"password"];
    return dic;
}

@end
