//
//  IREditAccountViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/10/13.
//
//

#import "IREditAccountViewController.h"
#import "IRMicroblogClient.h"
#import "UIImageView+IRAFNetworkingUtils.h"
#import "SVProgressHUD+IRUtils.h"
#import "UIAlertView+IRUtils.h"


@interface IREditAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) NSString *avatarURL;

- (IBAction)save:(UIBarButtonItem *)sender;
- (IBAction)changeAvatar:(UITapGestureRecognizer *)sender;

@end

@implementation IREditAccountViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // load user information
    IRUser *user = [IRMicroblogClient sharedClient].user;
    self.username.text = user.username;
    self.firstName.text = user.firstName;
    self.lastName.text = user.lastName;
    self.email.text = user.email;
    self.avatarURL = user.avatarURL;
    NSURL *avatarURL = [NSURL URLWithString:user.avatarURL];
    UIImage *placeholder = [UIImage imageNamed:IRProfilePictureImage];
    [self.avatar setImageWithURLWithActivityIndicator:avatarURL placeholderImage:placeholder];
}

- (void)viewDidUnload {
    [self setUsername:nil];
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setAvatar:nil];
    [super viewDidUnload];
}

#pragma mark - Event handling

- (IBAction)save:(UIBarButtonItem *)sender {
#warning Add validation
    [SVProgressHUD showDefault];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    IRUser *updatedUser = [[IRUser alloc] init];
    updatedUser.resourceURI = user.resourceURI;
    updatedUser.firstName = self.firstName.text;
    updatedUser.lastName = self.lastName.text;
    updatedUser.username = self.username.text;
    updatedUser.email = self.email.text;
    updatedUser.avatarURL = self.avatarURL;
    [[IRMicroblogClient sharedClient] putPath:updatedUser.resourceURI parameters:[updatedUser dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // reload user information
        IRUser *user = [IRMicroblogClient sharedClient].user;
        [[IRMicroblogClient sharedClient] getPath:user.resourceURI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [IRMicroblogClient sharedClient].user = [[IRUser alloc] initWithDictionary:responseObject];
            [SVProgressHUD showSuccessWithStatus:@"Account information updated"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't reload user"];
        }];        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
#warning Show proper error messages
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't update user"];
    }];
}

- (IBAction)changeAvatar:(UITapGestureRecognizer *)sender {
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    [picker setDelegate:self];
    [picker setDefaultAccessToken:kChuteAccessToken];
    [self presentModalViewController:picker animated:YES];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.username){
        [self.firstName becomeFirstResponder];
    }
    else if(textField == self.firstName){
        [self.lastName becomeFirstResponder];
    }
    else if(textField == self.lastName){
        [self.email becomeFirstResponder];
    }
    else if(textField == self.email){
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - AvatarPickerPlus methods

-(void)showAvatarPickerPlus{
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    [picker setDelegate:self];
    [picker setDefaultAccessToken:kChuteAccessToken];
    [self presentModalViewController:picker animated:YES];
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.avatar setImage:[info objectForKey:AvatarPickerImage]];
    self.avatarURL = [info objectForKey:AvatarPickerURLString];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker{
    [self dismissModalViewControllerAnimated:YES];
}

@end
