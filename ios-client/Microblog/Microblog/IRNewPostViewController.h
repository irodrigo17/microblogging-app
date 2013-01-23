//
//  IRNewMessageViewController.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRViewController.h"
#import "IRPost.h"

@interface IRNewPostViewController : IRViewController

@property (strong, nonatomic) IRPost *inReplyTo;

@end
