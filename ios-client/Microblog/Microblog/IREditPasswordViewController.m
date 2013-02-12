//
//  IREditPasswordViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/10/13.
//
//

#import "IREditPasswordViewController.h"
#import "IRMicroblogClient.h"

@interface IREditPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *currentPassword;
@property (weak, nonatomic) IBOutlet UITextField *updatedPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmation;

- (IBAction)save:(UIBarButtonItem *)sender;

- (NSArray*)validate;

@end

@implementation IREditPasswordViewController

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.currentPassword){
        [self.updatedPassword becomeFirstResponder];
    }
    else if(textField == self.updatedPassword){
        [self.confirmation becomeFirstResponder];
    }
    else if(textField == self.confirmation){
        [textField resignFirstResponder];
        [self save:nil];
    }
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidUnload {
    [self setCurrentPassword:nil];
    [self setUpdatedPassword:nil];
    [self setConfirmation:nil];
    [super viewDidUnload];
}

#pragma mark - Event handling

- (IBAction)save:(UIBarButtonItem *)sender {
    NSArray *errors = [self validate];
    if([errors count]){
        NSMutableString *message = [[NSMutableString alloc] initWithString:@"Found some errors:"];
        for(NSString *error in errors){
            [message appendFormat:@"\n%@", error];
        }
        [UIAlertView showSimpleAlertViewWithMessage:message];
    }
    else{
        [SVProgressHUD showDefault];
        IRUser *user = [IRMicroblogClient sharedClient].user;
        [[IRMicroblogClient sharedClient] patchPath:user.resourceURI parameters:@{@"old_pass": self.currentPassword.text, @"new_pass":self.updatedPassword.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"Password updated"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            NSString *message;
            if(operation.response.statusCode == 400){
                message = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
                
            }
            if(!message){
                message = @"Can't update password";
            }
            [UIAlertView showSimpleAlertViewWithMessage:message];
        }];
    }    
}

#pragma mark - Private methods

- (NSArray*)validate
{
    NSMutableArray *errors = [NSMutableArray array];
    if(![self.currentPassword.text length]){
        [errors addObject:@"Current password is required."];
    }
    if(![self.updatedPassword.text length]){
        [errors addObject:@"New password is required."];
    }
    if(![self.confirmation.text length]){
        [errors addObject:@"Password confirmation is required."];
    }
    if([self.updatedPassword.text length] < IRMinPasswordLength){
        [errors addObject:[NSString stringWithFormat:@"Password must be at least %i characters.", IRMinPasswordLength]];
    }
    if(![self.updatedPassword.text isEqualToString:self.confirmation.text]){
        [errors addObject:@"Passwords don't match."];
    }
    return errors;
}

@end
