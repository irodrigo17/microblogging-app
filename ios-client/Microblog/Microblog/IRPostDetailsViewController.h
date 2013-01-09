//
//  IRPostDetailsViewController.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRViewController.h"
#import "IRPost.h"

@interface IRPostDetailsViewController : IRViewController

/**
 * Set the post before the view loads and it will be populated with post data.
 */
@property (strong, nonatomic) IRPost *post;

@end
