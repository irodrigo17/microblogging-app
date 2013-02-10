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
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (strong, nonatomic) NSString *avatarURL;

- (IBAction)signUp;
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
        [textField resignFirstResponder];
        [self choosePicture];
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
    [self setProfilePicture:nil];
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
    user.avatarURL = self.avatarURL;
    // post user
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] postPath:[IRUser resourcePath] parameters:[user dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (IBAction)choosePicture{
    [self showAvatarPickerPlus];
}

#pragma mark - AvatarPickerPlus methods

-(void)showAvatarPickerPlus{
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    [picker setDelegate:self];
    [picker setDefaultAccessToken:kChuteAccessToken];
    [self presentModalViewController:picker animated:YES];
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.profilePicture setImage:[info objectForKey:AvatarPickerImage]];
    self.avatarURL = [info objectForKey:AvatarPickerURLString];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker{
    [self dismissModalViewControllerAnimated:YES];
}

@end
