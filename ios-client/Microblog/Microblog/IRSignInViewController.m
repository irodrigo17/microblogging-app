//
//  IRLoginViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRSignInViewController.h"
#import "IRMicroblogClient.h"

@interface IRSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)login;

@end

@implementation IRSignInViewController

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
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.emailTextField.text, @"email", 
                                self.passwordTextField.text, @"password",
                                nil];
    [self showDefaultProgressHUD];
    [[IRMicroblogClient sharedClient] postPath:@"sign_in" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        IRDLog(@"Sign in successfull!\n"
               "operation: %@\n"
               "responseObject: %@", operation, responseObject);
        [self dismissProgressHUD];
        [self performSegueWithIdentifier:@"IRModalMessages" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismissProgressHUD];
        if(!operation.response){
            IRELog(@"operation: %@\n"
                   "error: %@", operation, error);
            [self showSimpleAlertViewWithMessage:@"Can't sign in."];
        }
        else if(operation.response.statusCode == IRHTTPStatusCodeNotFound){
            [self showSimpleAlertViewWithMessage:@"Invalid user/password combination."];
        }
        else{
            [self showSimpleAlertViewWithMessage:@"Unexpected error."];
        }
        
    }];
    
}

@end
