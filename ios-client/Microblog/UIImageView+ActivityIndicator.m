//
//  UIImageView+ActivityIndicator.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/11/13.
//
//

#import "UIImageView+ActivityIndicator.h"
#import <objc/runtime.h>


@interface UIImageView (ActivityIndicatorPrivate)
@property (strong, nonatomic) UIView *overlay;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end


@implementation UIImageView (ActivityIndicatorPrivate)
@dynamic overlay;
@dynamic activityIndicator;
@end


@implementation UIImageView (ActivityIndicator)

static char *kIRActivityIndicatorKey;
static char *kIROverlayKey;

- (void)showActivityIndicator
{
    if(!self.activityIndicator){
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    if(!self.overlay){
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.overlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    }
    [self addSubview:self.overlay];
    [self addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

- (void)hideActivityIndicator
{
    [self.overlay removeFromSuperview];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];    
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator
{
    objc_setAssociatedObject(self, kIRActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView*)activityIndicator
{
    return objc_getAssociatedObject(self, kIRActivityIndicatorKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, kIROverlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)overlay
{
    return objc_getAssociatedObject(self, kIROverlayKey);
}

@end
