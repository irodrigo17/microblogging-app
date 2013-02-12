//
//  UIImageView+IRAFNetworkingUtils.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/11/13.
//
//

#import "UIImageView+IRAFNetworkingUtils.h"

@implementation UIImageView (IRAFNetworkingUtils)

- (void)setImageWithURLWithActivityIndicator:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
    [self showActivityIndicator];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPShouldHandleCookies:NO];
    [request addValue:@"image/*; image/jpg" forHTTPHeaderField:@"Accept"];
    
    __weak UIImageView *imageView = self;
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [imageView hideActivityIndicator];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [imageView hideActivityIndicator];
    }];
}

@end
