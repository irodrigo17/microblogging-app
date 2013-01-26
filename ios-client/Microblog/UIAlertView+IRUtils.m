//
//  UIAlertView+IRUtils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/18/13.
//
//

#import "UIAlertView+IRUtils.h"

@implementation UIAlertView (IRUtils)

+ (void)showSimpleAlertViewWithMessage:(NSString*)message
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]; // Not so nice, but not a clue if this can be done properly, got this from an article from Apple here http://developer.apple.com/library/mac/#qa/qa1544/_index.html
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


+ (void)showNotImplementedYetAlert
{
    [self showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

@end
