//
//  IRUserDetailsViewController.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/25/13.
//
//

#import <UIKit/UIKit.h>
#import "IRUser.h"


@interface IRUserDetailsViewController : UIViewController

/**
 * Set this property before the view loads so it updates with it.
 */
@property IRUser *user;

@end
