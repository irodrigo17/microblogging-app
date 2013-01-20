//
//  IRSignUpViewController.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRViewController.h"

@protocol IRSignUpViewControllerDelegate <NSObject>

@required

- (void)didSignupWithUsername:(NSString*)username password:(NSString*)password;

@end

@interface IRSignUpViewController : IRViewController <UITextFieldDelegate>

@property (weak, nonatomic) id<IRSignUpViewControllerDelegate> delegate;

@end
