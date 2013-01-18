//
//  SVProgressHUD+Utils.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/18/13.
//
//

#import "SVProgressHUD.h"

@interface SVProgressHUD (IRUtils)

/**
 * Shows a default prograss HUD with a default message.
 */
+ (void)showDefault;


/**
 * Shows a default prograss HUD with thegiven message.
+*/
+ (void)showDefaultWithMessage:(NSString*)message;

@end
