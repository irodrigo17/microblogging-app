//
//  UIAlertView+IRUtils.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/18/13.
//
//

#import <UIKit/UIKit.h>

@interface UIAlertView (IRUtils)

/**
 * Shows a simple UIAlertView on the calling view controller with the given message.
 * The alert view has a default cancel button, the app name as the title and no delegate.
 * This is usefull for showing simple informative messages to the user.
 * @param message The message to be displayed in the alert view.
 */
+ (void)showSimpleAlertViewWithMessage:(NSString*)message;

@end
