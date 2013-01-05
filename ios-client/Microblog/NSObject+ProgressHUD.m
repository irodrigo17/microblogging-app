//
//  NSObject+ProgressHUD.m
//  Lively
//
//  Created by Ignacio Rodrigo on 11/12/12.
//
//

#import "NSObject+ProgressHUD.h"
#import "SVProgressHUD.h"

@implementation NSObject (ProgressHUD)

- (void)showDefaultProgressHUD
{
    [self showDefaultProgressHUDWithMessage:@"Loading..."];
}

- (void)showDefaultProgressHUDWithMessage:(NSString*)message
{
    [SVProgressHUD showWithStatus:message
                         maskType:SVProgressHUDMaskTypeGradient];
}

- (void)dismissProgressHUD
{
    [SVProgressHUD dismiss];
}

@end
