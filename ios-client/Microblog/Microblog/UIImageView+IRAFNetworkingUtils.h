//
//  UIImageView+IRAFNetworkingUtils.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/11/13.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "UIImageView+ActivityIndicator.h"

@interface UIImageView (IRAFNetworkingUtils)

/**
 It behaves like UIImageView+AFNetworking setImageWithURL:placeholderImage: but shows an activity indicator from UIImageView+ActivityIndicator while the image loads.
 */
- (void)setImageWithURLWithActivityIndicator:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

@end
