//
//  IRLoginViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRLoginViewController.h"

@interface IRLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)login;

@end

@implementation IRLoginViewController

@synthesize emailTextField;
@synthesize passwordTextField;

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.emailTextField){
        [self.passwordTextField becomeFirstResponder];
    }
    else if(textField == self.passwordTextField){
        [textField resignFirstResponder];
        [self login];
    }
    return YES;
}

#pragma mar - Event handling

- (IBAction)login {
    [self.view endEditing:YES];
    [self showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

@end
