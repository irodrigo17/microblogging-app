//
//  IRPostDetailsViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPostDetailsViewController.h"
#import "IRDateFormatterCache.h"
#import "IRUser.h"
#import "IRMicroblogClient.h"

@interface IRPostDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharesLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *repliesLabel;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UIButton *originalPostButton;

@property (strong, nonatomic) IRUser *user;

- (void)updateUI;
- (void)loadUser;

- (IBAction)viewReplies;
- (IBAction)viewOriginalPost;
- (IBAction)like;
- (IBAction)share;
- (IBAction)follow;
- (IBAction)reply;

@end

@implementation IRPostDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUser];
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [self setDateLabel:nil];
    [self setPost:nil];
    [self setUsernameLabel:nil];
    [self setSharesLabel:nil];
    [self setLikesLabel:nil];
    [self setRepliesLabel:nil];
    [self setRepliesButton:nil];
    [self setOriginalPostButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private methods

- (void)updateUI
{
    self.usernameLabel.text = [NSString stringWithFormat:@"%@ wrote:", self.user.username];
    self.textView.text = self.post.text;
    NSDateFormatter *df = [IRDateFormatterCache sharedDateFormatter];
    self.dateLabel.text = [df stringFromDate:self.post.createdDate];
    self.sharesLabel.text = [self.post.shares description];
    self.likesLabel.text = [self.post.likes description];
    self.repliesLabel.text = [self.post.replies description];
    self.originalPostButton.enabled = self.post.inReplyTo != nil;
    self.repliesButton.enabled = [self.post.replies integerValue] > 0;
}

- (void)loadUser
{
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] getPath:self.post.user parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        self.user = [[IRUser alloc] initWithDictionary:responseObject];
        [self updateUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load user."];
    }];
}

#pragma mark - Event handling

- (IBAction)viewReplies {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)viewOriginalPost {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)like {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)share {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)follow {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)reply {
    [UIAlertView showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

@end
