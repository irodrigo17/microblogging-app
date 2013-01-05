//
//  NSObject+AlertView.h
//  AlertViewCategoryDemo
//
//  Created by Ignacio Rodrigo on 12/14/12.
//  Copyright (c) 2012 Ignacio Rodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This category is meant to encapsulate and simplify common tasks that involve showing an UIAlertView.
 */
@interface NSObject (AlertView)

/**
 * Shows a simple UIAlertView on the calling view controller with the given message.
 * The alert view has a default cancel button, the app name as the title and no delegate.
 * This is usefull for showing simple informative messages to the user.
 * @param message The message to be displayed in the alert view.
 */
- (void)showSimpleAlertViewWithMessage:(NSString*)message;

@end
