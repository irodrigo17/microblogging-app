//
//  IRLoginViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRSignInViewController.h"
#import "IRMicroblogClient.h"
#import "BButton.h"

#define IRModalSignUp @"IRModalSignUp"

#define IRProductionSegmentIndex 0
#define IRDevelopmentSegmentIndex 1

@interface IRSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet BButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet BButton *forgotUsernameButton;

- (IBAction)login;
- (IBAction)switchServers:(UISegmentedControl*)sender;
- (IBAction)forgotPassword;
- (IBAction)forgotUsername;


- (void)loginWithUsername:(NSString*)username password:(NSString*)password;


@end

@implementation IRSignInViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.forgotPasswordButton.color = IRLightGray;
    self.forgotUsernameButton.color = IRLightGray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setForgotPasswordButton:nil];
    [self setForgotUsernameButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:IRModalSignUp]){
        IRSignUpViewController *vc = (IRSignUpViewController*)segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.usernameTextField){
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
    [self loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    
}

- (IBAction)switchServers:(UISegmentedControl*)sender {
    if(sender.selectedSegmentIndex == IRProductionSegmentIndex){
        [[IRMicroblogClient sharedClient] updateBaseURL:IRBaseURLProd];
    }
    else{
        [[IRMicroblogClient sharedClient] updateBaseURL:IRBaseURLDev];
    }
}

- (IBAction)forgotPassword
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Password" message:@"Enter your email address to reset your password:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset Password", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)forgotUsername
{
    [UIAlertView showNotImplementedYetAlert];
}

#pragma mark - IRSignUpViewControllerDelegate methods

- (void)didSignupWithUsername:(NSString *)username password:(NSString *)password
{
    [self loginWithUsername:username password:password];
}

#pragma mark - Private methods

- (void)loginWithUsername:(NSString*)username password:(NSString*)password
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                username, @"username",
                                password, @"password",
                                nil];
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] postPath:@"login/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        IRDLog(@"Sign in successfull!\n"
               "operation: %@\n"
               "responseObject: %@", operation, responseObject);
        [[IRMicroblogClient sharedClient] setUsername:username
                                               APIKey:[responseObject valueForKey:@"api_key"]];
        [[IRMicroblogClient sharedClient] getPath:[responseObject valueForKey:@"user"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD dismiss];
            [IRMicroblogClient sharedClient].user = [[IRUser alloc] initWithDictionary:responseObject];
            [self performSegueWithIdentifier:@"IRModalMessages" sender:self];            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [[IRMicroblogClient sharedClient] logout];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't get user."];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSString *message;
        if(operation.response.statusCode == 401){
            message = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        }
        if(!message){
            message = @"Can't sign in.";
        }
        [UIAlertView showSimpleAlertViewWithMessage:message];
        
    }];
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [SVProgressHUD showDefault];
        NSString *email = [alertView textFieldAtIndex:0].text;
        [[IRMicroblogClient sharedClient] postPath:@"lostpassword/" parameters:@{@"email":email} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Email sent. Please check your inbox for instructions."];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't reset password."];
        }];
    }
}



@end
