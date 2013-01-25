//
//  IRMessagesViewController.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRPaginatedArray.h"
#import "IRPost.h"

@interface IRPostsViewController : UITableViewController

/**
 * Set this property before the view appears to load the replies for the given post.
 */
@property (strong, nonatomic) IRPost *originalPost;

@end
