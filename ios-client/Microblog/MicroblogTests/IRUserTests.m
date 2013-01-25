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

- (void)testInitWithDictionary
{
    // complete dictionary
    NSString *firstName = @"John";
    NSString *lastName = @"Doe";
    NSString *email = @"jdoe@email.com";
    NSNumber *userId = [NSNumber numberWithInt:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         firstName, IRFirstNameFieldKey,
                         lastName, IRLastNameFieldKey,
                         email, IREmailFieldKey,
                         userId, IRIdFieldKey,
                         nil];
    IRUser *user = [[IRUser alloc] initWithDictionary:dic];
    STAssertEquals(firstName, user.firstName, @"Error");
    STAssertEquals(lastName, user.lastName, @"Error");
    STAssertEquals(email, user.email, @"Error");
    STAssertEquals(userId, user.modelId, @"Error");
    
    // nil dictionary
    user = [[IRUser alloc] initWithDictionary:nil];
    STAssertNotNil(user, @"Error");
    
}

- (void)testDictionaryRepresentation
{
    // complete dictionary
    IRUser *user = [[IRUser alloc] init];
    user.firstName = @"John";
    user.lastName = @"Doe";
    user.email = @"jdoe@email.com";
    user.password = @"pass";
    user.modelId = [NSNumber numberWithInt:1];
    
    NSDictionary *dic = [user dictionaryRepresentation];
    NSString *firstName = [dic valueForKey:IRFirstNameFieldKey];
    NSString *lastName = [dic valueForKey:IRLastNameFieldKey];
    NSString *email = [dic valueForKey:IREmailFieldKey];
    NSString *pass = [dic valueForKey:IRPasswordFieldKey];
    
    STAssertEquals(user.firstName, firstName, @"Error");
    STAssertEquals(user.lastName, lastName, @"Error");
    STAssertEquals(user.email, email, @"Error");
    STAssertEquals(user.password, pass, @"Error");
    
    // empty dictionary
    user = [[IRUser alloc] init];
    dic = [user dictionaryRepresentation];
    STAssertNotNil(dic, nil);
    STAssertFalse([dic count], @"Error, dic should be empty. dic: %@", dic);
    
}

@end
