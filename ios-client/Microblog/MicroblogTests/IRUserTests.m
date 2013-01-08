//
//  IRUserTests.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRUserTests.h"
#import "IRUser.h"

@implementation IRUserTests

// All code under test must be linked into the Unit Test bundle
- (void)testMath
{
    STAssertTrue((1 + 1) == 2, @"Compiler isn't feeling well today :-(");
}

- (void)testInitWithDictionary
{
    // complete dictionary
    NSString *name = @"John Doe";
    NSString *email = @"jdoe@email.com";
    NSString *pass = @"pass";
    NSNumber *userId = [NSNumber numberWithInt:1];    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         name, @"name", 
                         email, @"email", 
                         pass, @"password", 
                         userId, @"id", 
                         nil];
    IRUser *user = [[IRUser alloc] initWithDictionary:dic];
    STAssertEquals(name, user.name, @"Error");
    STAssertEquals(email, user.email, @"Error");
    STAssertEquals(pass, user.password, @"Error");
    STAssertEquals(userId, user.modelId, @"Error");
    
    // nil dictionary
    user = [[IRUser alloc] initWithDictionary:nil];
    STAssertNotNil(user, @"Error");
    
    // incomplee dictionary
    name = @"John Doe";
    email = @"jdoe@email.com";
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           name, @"name", 
           email, @"email", 
           nil];
    user = [[IRUser alloc] initWithDictionary:dic];
    STAssertEquals(name, user.name, @"Error");
    STAssertEquals(email, user.email, @"Error");
    STAssertNil(user.password, @"Error");
    
}

- (void)testDictionaryRepresentation
{
    // complete dictionary
    IRUser *user = [[IRUser alloc] init];
    user.name = @"John Doe";
    user.email = @"jdoe@email.com";
    user.password = @"pass";
    user.modelId = [NSNumber numberWithInt:1];
    
    NSDictionary *dic = [user dictionaryRepresentation];
    NSString *name = [dic valueForKey:@"name"];
    NSString *email = [dic valueForKey:@"email"];
    NSString *pass = [dic valueForKey:@"password"];
    NSNumber *userId = [dic valueForKey:@"id"];
    
    STAssertEquals(user.name, name, @"Error");
    STAssertEquals(user.email, email, @"Error");
    STAssertEquals(user.password, pass, @"Error");
    STAssertEquals(user.modelId, userId, @"Error");
    
    // empty dictionary
    user = [[IRUser alloc] init];
    dic = [user dictionaryRepresentation];
    STAssertFalse([dic count], @"Error, dic should be empty. dic: %@", dic);
    
    // incomplete dictionary
    user = [[IRUser alloc] init];
    user.name = @"John Doe";
    user.email = @"jdoe@email.com";
    
    dic = [user dictionaryRepresentation];
    name = [dic valueForKey:@"name"];
    email = [dic valueForKey:@"email"];
    
    STAssertEquals(user.name, name, @"Error");
    STAssertEquals(user.email, email, @"Error");
    
}

@end
