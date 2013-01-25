//
//  IRUserDetailsViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/25/13.
//
//

#import "IRUserDetailsViewController.h"

@interface IRUserDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *following;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *posts;

@property (weak, nonatomic) IBOutlet UIButton *followButton;

- (IBAction)follow;

- (void)updateUI;

@end

@implementation IRUserDetailsViewController

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
    [super viewDidUnload];
}

- (IBAction)follow {
    
}

- (void)updateUI
{
    self.username.text = self.user.username;
    self.firstName.text = self.user.firstName;
    self.lastName.text = self.user.lastName;
    self.email.text = self.user.email;
    self.following.text = [self.user.following stringValue];
    self.followers.text = [self.user.followers stringValue];
    self.posts.text = [self.user.postsCount stringValue];
    self.followButton.enabled = [self.user.followedByCurrentUser boolValue];
}

@end
