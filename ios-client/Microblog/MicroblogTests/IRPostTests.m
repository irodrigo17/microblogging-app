//
//  IRPostTests.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPostTests.h"
#import "IRPost.h"

@implementation IRPostTests

- (void)testInitWithDictionary
{
    // full dictionary
    NSNumber *postId = [NSNumber numberWithInt:1];
    NSString *text = @"Text goes here.";
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         text, IRTextFieldKey, 
                         postId, IRIdFieldKey, 
                         nil];
    IRPost *post = [[IRPost alloc] initWithDictionary:dic];
    STAssertTrue([postId isEqualToNumber:post.modelId], @"Error");
    STAssertTrue([text isEqualToString:post.text], @"Error");
    
    // empty
    dic = [NSDictionary dictionary];
    post = [[IRPost alloc] initWithDictionary:dic];
    STAssertNotNil(post, @"Error");
    STAssertNil(post.modelId, @"Error");
    STAssertNil(post.text, @"Error");
}

- (void)testDictionaryRepresentation
{
    // post data and model id
    IRPost *post = [[IRPost alloc] initWithText:@"Some text" user:@"/api/v1/user/1/"];
    post.modelId = [NSNumber numberWithInt:9];
    
    NSDictionary *dic = [post dictionaryRepresentation];
    NSString *text = [dic valueForKey:IRTextFieldKey];
    NSString *user = [dic valueForKey:IRUserFieldKey];
    
    STAssertTrue([dic count] == 2, nil);
    STAssertTrue([text isEqualToString:post.text], @"Error");
    STAssertTrue([user isEqualToString:post.user], @"Error");
    
    // no data
    post = [[IRPost alloc] init];
    dic = [post dictionaryRepresentation];
    STAssertNotNil(dic, @"Error");
    STAssertFalse([dic count], @"Error");
}

@end
