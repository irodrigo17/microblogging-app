//
//  UIViewController+ProgressHUD.m
//  Lively
//
//  Created by Ignacio Rodrigo on 11/12/12.
//
//

#import "UIViewController+ProgressHUD.h"
#import "SVProgressHUD.h"

@implementation UIViewController (ProgressHUD)

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
