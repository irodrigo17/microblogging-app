//
//  IRModelTests.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRModelTests.h"
#import "IRModel.h"

@implementation IRModelTests

- (void)testInitWithDictionary
{
    // complete dictionary
    NSString *resourceURI = @"/api/v1/user/1/";
    NSNumber *modelId = [NSNumber numberWithInt:1];
    NSDictionary *dic = @{
        IRIdFieldKey: modelId,
        IRResourceURIFieldKey: resourceURI
    };
    IRModel *model = [[IRModel alloc] initWithDictionary:dic];
    STAssertEquals(resourceURI, model.resourceURI, @"Error");
    STAssertEquals(modelId, model.modelId, @"Error");
    
    // empty dictionary
    model = [[IRModel alloc] initWithDictionary:nil];
    STAssertNotNil(model, @"Error");
    STAssertNil(model.modelId, @"Error");
    STAssertNil(model.resourceURI, @"Error");
    
}

- (void)testDictionaryRepresentation
{
    IRModel *model = [[IRModel alloc] init];
    STAssertTrue([[model dictionaryRepresentation] count] == 0, nil);
    model.modelId = [NSNumber numberWithInt:2];
    STAssertTrue([[model dictionaryRepresentation] count] == 0, nil);
    model.resourceURI = @"/api/v1/user/1/";
    STAssertTrue([[model dictionaryRepresentation] count] == 0, nil);
}

- (void)testIdFromResourceURI
{
    NSString *resourceURI = @"/api/v1/user/1/";
    STAssertTrue([[IRModel idFromResourceURI:resourceURI] integerValue] == 1, nil);
}

@end
