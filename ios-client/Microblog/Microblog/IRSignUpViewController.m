//
//  IRSignUpViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRSignUpViewController.h"

@interface IRSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;

- (IBAction)signUp;
- (IBAction)cancel;

@end

@implementation IRSignUpViewController

@synthesize nameTextField;
@synthesize emailTextField;
@synthesize passwordTextField;
@synthesize passwordConfirmationTextField;

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.nameTextField){
        [self.emailTextField becomeFirstResponder];
    }
    else if(textField == self.emailTextField){
        [self.passwordTextField becomeFirstResponder];
    }
    else if(textField == self.passwordTextField){
        [self.passwordConfirmationTextField becomeFirstResponder];
    }
    else if(textField == self.passwordConfirmationTextField){
        [self signUp];
    }
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidUnload {
    [self setNameTextField:nil];
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    [self setPasswordConfirmationTextField:nil];
    [super viewDidUnload];
}

#pragma mark - Event handling

- (IBAction)signUp
{
    [self.view endEditing:YES];
    [self showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
