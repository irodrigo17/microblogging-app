//
//  IRSignUpViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRSignUpViewController.h"
#import "IRUser.h"
#import "IRMicroblogClient.h"

@interface IRSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

- (IBAction)signUp;
- (IBAction)cancel;
- (IBAction)choosePicture;


@end

@implementation IRSignUpViewController

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.usernameTextField){
        [self.firstNameTextField becomeFirstResponder];
    }
    else if(textField == self.firstNameTextField){
        [self.lastNameTextField becomeFirstResponder];
    }
    else if(textField == self.lastNameTextField){
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
    [self setLastNameTextField:nil];
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    [self setPasswordConfirmationTextField:nil];
    [self setFirstNameTextField:nil];
    [self setUsernameTextField:nil];
    [super viewDidUnload];
}

#pragma mark - Event handling

- (IBAction)signUp
{
    [self.view endEditing:YES];
#warning Validate fields!
    // create user
    IRUser *user = [[IRUser alloc] initWithFirstName:self.firstNameTextField.text
                                            lastName:self.lastNameTextField.text
                                            username:self.usernameTextField.text
                                               email:self.emailTextField.text
                                            password:self.passwordTextField.text];
    // post user
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] postPath:IRUserResourceURL parameters:[user dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        IRDLog(@"Sign up success!\noperation: %@\nresponseObject: %@", operation, responseObject);
        [SVProgressHUD dismiss];
        [self.delegate didSignupWithUsername:user.username password:user.password];
        [self dismissModalViewControllerAnimated:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSString *message = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        if(!message || operation.response.statusCode == 500){
            message = @"Can't sign up.";
        }
        [UIAlertView showSimpleAlertViewWithMessage:message];
    }];
}

- (IBAction)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)choosePicture {
    [UIAlertView showNotImplementedYetAlert];
}

@end
