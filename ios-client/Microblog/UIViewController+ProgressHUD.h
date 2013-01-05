//
//  UIViewController+ProgressHUD.h
//  Lively
//
//  Created by Ignacio Rodrigo on 11/12/12.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (ProgressHUD)

/**
 * Shows a default prograss HUD with a default message.
 */
- (void)showDefaultProgressHUD;


/**
 * Shows a default prograss HUD with thegiven message.
 */
- (void)showDefaultProgressHUDWithMessage:(NSString*)message;


/**
 * Dismisses the progress HUD if any.
 */
- (void)dismissProgressHUD;

@end
