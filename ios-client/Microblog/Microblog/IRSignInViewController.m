//
//  IRLoginViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRSignInViewController.h"
#import "IRMicroblogClient.h"

#define IRModalSignUp @"IRModalSignUp"

#define IRProductionSegmentIndex 0
#define IRDevelopmentSegmentIndex 1

@interface IRSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)login;
- (IBAction)switchServers:(UISegmentedControl*)sender;


- (void)loginWithUsername:(NSString*)username password:(NSString*)password;

@end

@implementation IRSignInViewController

#pragma mark - View lifecycle

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
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't sign in."];
        
    }];
}

@end
