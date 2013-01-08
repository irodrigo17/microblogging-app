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
    NSString *createdAt = @"2013-01-05T22:32:39Z";
    NSString *updatedAt = @"2014-02-27T21:33:99Z";
    NSNumber *modelId = [NSNumber numberWithInt:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         createdAt, IRCreatedAtFieldKey, 
                         updatedAt, IRUpdatedAtFieldKey, 
                         modelId, IRIdFieldKey, 
                         nil];
    IRModel *model = [[IRModel alloc] initWithDictionary:dic];    
    
    STAssertEquals(modelId, model.modelId, @"Error");
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2013;
    components.month = 1;
    components.day = 5;
    components.hour = 22;
    components.minute = 32;
    components.second = 39;
    components.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSDate *date = [calendar dateFromComponents:components];
    STAssertTrue([date isEqualToDate:model.createdAt], 
                 @"Error, expectedDate: %@ parsedDate: %@", 
                 date, model.createdAt);
    
    components = [[NSDateComponents alloc] init];
    components.year = 2014;
    components.month = 2;
    components.day = 27;
    components.hour = 21;
    components.minute = 33;
    components.second = 99;
    components.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    date = [calendar dateFromComponents:components];
    STAssertTrue([date isEqualToDate:model.updatedAt], 
                   @"Error, \nexpectedDate: %@ \nparsedDate: %@", 
                   date, model.updatedAt);
    
    // empty dictionary
    model = [[IRModel alloc] initWithDictionary:nil];
    STAssertNotNil(model, @"Error");
    STAssertNil(model.modelId, @"Error");
    STAssertNil(model.createdAt, @"Error");
    STAssertNil(model.updatedAt, @"Error");
    
    // incomplete dictionary
    createdAt = @"2013-01-05T22:32:39+01:00";
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         createdAt, IRCreatedAtFieldKey, 
                         nil];
    model = [[IRModel alloc] initWithDictionary:dic];    
    
    components = [[NSDateComponents alloc] init];
    components.year = 2013;
    components.month = 1;
    components.day = 5;
    components.hour = 22;
    components.minute = 32;
    components.second = 39;
    components.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:1*60*60];
    date = [calendar dateFromComponents:components];
    STAssertTrue([date isEqualToDate:model.createdAt], 
                 @"Error, expectedDate: %@ parsedDate: %@", 
                 date, model.createdAt);
    
#warning Add tests for different timezones! Need to define timezone format on the API.
    
}

- (void)testDictionaryRepresentation
{
    IRModel *model = [[IRModel alloc] init];
    model.modelId = [NSNumber numberWithInt:2];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2013;
    components.month = 12;
    components.day = 17;
    components.hour = 17;
    components.minute = 9;
    components.second = 16;
    components.timeZone = [NSTimeZone defaultTimeZone];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    model.createdAt = [calendar dateFromComponents:components];
    
    components = [[NSDateComponents alloc] init];
    components.year = 2012;
    components.month = 11;
    components.day = 16;
    components.hour = 16;
    components.minute = 8;
    components.second = 15;
    model.updatedAt = [calendar dateFromComponents:components];
    
    NSDictionary *dic = [model dictionaryRepresentation];
    NSString *createdAt = [dic valueForKey:IRCreatedAtFieldKey];
    NSString *updatedAt = [dic valueForKey:IRUpdatedAtFieldKey];
    NSNumber *modelId = [dic valueForKey:IRIdFieldKey];
    
    STAssertTrue([@"2013-12-17T17:09:16-0200" isEqualToString:createdAt], @"Error, createdAt: %@", createdAt);
    STAssertTrue([@"2012-11-16T16:08:15-0200" isEqualToString:updatedAt], @"Error, updatedAt: %@", updatedAt);
    STAssertTrue([model.modelId isEqualToNumber:modelId], @"Error");
    
#warning Check API format for timezones!
    
}

@end
