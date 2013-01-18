//
//  SVProgressHUD+Utils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/18/13.
//
//

#import "SVProgressHUD+IRUtils.h"

@implementation SVProgressHUD (IRUtils)

+ (void)showDefault
{
    [SVProgressHUD showDefaultWithMessage:@"Loading..."];
}

+ (void)showDefaultWithMessage:(NSString*)message
{
    [SVProgressHUD showWithStatus:message
                         maskType:SVProgressHUDMaskTypeGradient];
}

@end
