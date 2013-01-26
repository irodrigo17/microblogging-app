//
//  IRUserDetailsViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/25/13.
//
//

#import "IRUserDetailsViewController.h"
#import "UIAlertView+IRUtils.h"
#import "IRMicroblogClient.h"


@interface IRUserDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *following;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *posts;

@property (weak, nonatomic) IBOutlet UIButton *followButton;

- (IBAction)followAction;
- (IBAction)followingAction;
- (IBAction)followersAction;
- (IBAction)postsAction;

- (void)updateUI;


@end

@implementation IRUserDetailsViewController

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsername:nil];
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setFollowing:nil];
    [self setFollowers:nil];
    [self setPosts:nil];
    [self setFollowButton:nil];
    [self setFollowing:nil];
    [super viewDidUnload];
}

#pragma mark - Event handling

- (IBAction)followAction {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)followersAction {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)followingAction {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)postsAction {
    [UIAlertView showNotImplementedYetAlert];
}

#pragma mark - Event handling methods

- (void)updateUI
{
    self.username.text = self.user.username;
    self.firstName.text = self.user.firstName;
    self.lastName.text = self.user.lastName;
    self.email.text = self.user.email;
    self.following.text = [self.user.following stringValue];
    self.followers.text = [self.user.followers stringValue];
    self.posts.text = [self.user.postsCount stringValue];
    NSString *followButtonTitle = [self.user.followedByCurrentUser boolValue] ? @"Unfollow" : @"Follow";
    [self.followButton setTitle:followButtonTitle forState:UIControlStateNormal];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    self.followButton.enabled = ![self.user.resourceURI isEqualToString:user.resourceURI];
}

@end
