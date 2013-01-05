//
//  NSObject+AlertView.m
//  AlertViewCategoryDemo
//
//  Created by Ignacio Rodrigo on 12/14/12.
//  Copyright (c) 2012 Ignacio Rodrigo. All rights reserved.
//

#import "NSObject+AlertView.h"

#define IRCancelButtonTitle @"OK" // Default title for the cancel button of the alert views.

@implementation NSObject (AlertView)

- (void)showSimpleAlertViewWithMessage:(NSString*)message
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]; // Not so nice, but not a clue if this can be done properly, got this from an article from Apple here http://developer.apple.com/library/mac/#qa/qa1544/_index.html
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName 
                                                    message:message 
                                                   delegate:nil 
                                          cancelButtonTitle:IRCancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

@end
