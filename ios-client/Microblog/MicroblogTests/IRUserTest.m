//
//  IRUserTest.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRUserTest.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation IRUserTest

// All code under test is in the iOS Application
- (void)testAppDelegate
{
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}

@end
