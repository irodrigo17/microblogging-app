//
//  IRPostCell.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import <UIKit/UIKit.h>
#import "IRPost.h"
#import "IRUser.h"

@interface IRPostCell : UITableViewCell{
    __strong IRPost *_post;
}

@property (strong, nonatomic) IRPost *post;

@end
