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
    self = [super initWithDictionary:dictionary];
    if(self){
        self.name = [dictionary valueForKey:IRNameFieldKey];
        self.email = [dictionary valueForKey:IREmailFieldKey];
        self.password = [dictionary valueForKey:IRPasswordFieldKey];
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
#warning Field names could be constants
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.name forKey:IRNameFieldKey];
    [dic setValue:self.email forKey:IREmailFieldKey];
    [dic setValue:self.password forKey:IRPasswordFieldKey];
    return dic;
}

@end
