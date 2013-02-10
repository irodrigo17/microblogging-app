//
//  IRPostDetailsViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPostDetailsViewController.h"
#import "IRNewPostViewController.h"
#import "IRDateFormatterCache.h"
#import "IRUser.h"
#import "IRMicroblogClient.h"
#import "IRLike.h"
#import "IRFollow.h"
#import "IRShare.h"
#import "IRPaginatedArray.h"
#import "IRPostsViewController.h"
#import "IRAPIWrapper.h"
#import "BButton.h"

#define IRPushNewPostFromDetail @"IRPushNewPostFromDetail"
#define IRPostsViewControllerId @"IRPostsViewController"
#define IRPostDetailsViewControllerId @"IRPostDetailsViewController"

@interface IRPostDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UIButton *originalPostButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet BButton *sharesButton;
@property (weak, nonatomic) IBOutlet BButton *likesButton;
@property (strong, nonatomic) IBOutletCollection(BButton) NSArray *buttons;

- (void)updateUI;
- (void)loadPost:(NSString*)postURI;
- (void)reloadPost;

- (IBAction)viewReplies;
- (IBAction)viewOriginalPost;
- (IBAction)like;
- (IBAction)share;
- (IBAction)follow;

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
    for(BButton *button in self.buttons){
        button.color = IRLightGray;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if(self.post){
        [self updateUI];
    }
    else if(self.postURI){
        [self loadPost:self.postURI];
    }
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [self setDateLabel:nil];
    [self setPost:nil];
    [self setUsernameLabel:nil];
    [self setRepliesButton:nil];
    [self setOriginalPostButton:nil];
    [self setLikeButton:nil];
    [self setShareButton:nil];
    [self setFollowButton:nil];
    [self setSharesButton:nil];
    [self setLikesButton:nil];
    [self setRepliesButton:nil];
    [self setButtons:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:IRPushNewPostFromDetail]){
        IRNewPostViewController *vc = segue.destinationViewController;
        vc.inReplyTo = self.post;
    }
}

#pragma mark - Private methods

- (void)updateUI
{
    self.usernameLabel.text = [NSString stringWithFormat:@"%@", self.post.user.username];
    self.textView.text = self.post.text;
    NSDateFormatter *df = [IRDateFormatterCache sharedDateFormatter];
    self.dateLabel.text = [df stringFromDate:self.post.createdDate];
    [self.sharesButton setTitle:[NSString stringWithFormat:@"%@ Shares", self.post.shares] forState:UIControlStateNormal];
    [self.likesButton setTitle:[NSString stringWithFormat:@"%@ Likes", self.post.likes] forState:UIControlStateNormal];
    [self.repliesButton setTitle:[NSString stringWithFormat:@"%@ Replies", self.post.replies] forState:UIControlStateNormal];
    self.originalPostButton.enabled = self.post.inReplyTo != nil;
    self.repliesButton.enabled = [self.post.replies integerValue] > 0;
    NSString *likeButtonTitle = [self.post.likedByCurrentUser boolValue] ? @"Unlike" : @"Like";
    [self.likeButton setTitle:likeButtonTitle forState:UIControlStateNormal];
    NSString *followButtonTitle = [self.post.user.followedByCurrentUser boolValue] ? @"Unfollow" : @"Follow";
    [self.followButton setTitle:followButtonTitle forState:UIControlStateNormal];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    self.followButton.enabled = ![self.post.user.resourceURI isEqualToString:user.resourceURI];
    NSString *shareButtonTitle = [self.post.sharedByCurrentUser boolValue] ? @"Unshare" : @"Share";
    [self.shareButton setTitle:shareButtonTitle forState:UIControlStateNormal];
    self.shareButton.enabled = ![self.post.user.resourceURI isEqualToString:user.resourceURI];
}

- (void)loadPost:(NSString*)postURI
{
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] getPath:postURI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        self.post = [[IRPost alloc] initWithDictionary:responseObject];
        [self updateUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load post."];
    }];
}

- (void)reloadPost
{
    [self loadPost:self.post.resourceURI];
}


#pragma mark - Event handling

- (IBAction)viewReplies {
    IRPostsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:IRPostsViewControllerId];
    vc.originalPost = self.post;
    [self.navigationController pushViewController:vc animated:YES];    
}

- (IBAction)viewOriginalPost {
    IRPostDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:IRPostDetailsViewControllerId];
    vc.postURI = self.post.inReplyTo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)like {
    [SVProgressHUD showDefault];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    if([self.post.likedByCurrentUser boolValue]){
        // find like instance
        NSDictionary *params = @{@"user":user.modelId, @"post":self.post.modelId};
        [[IRMicroblogClient sharedClient] getPath:[IRLike resourcePath] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            IRPaginatedArray *array = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRLike class]];
            IRLike *like = [array.objects lastObject];
            if(like){
                // delete like instance
                [[IRMicroblogClient sharedClient] deletePath:like.resourceURI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self reloadPost];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [SVProgressHUD dismiss];
                    [UIAlertView showSimpleAlertViewWithMessage:@"Can't delete like instance."];
                }];
            }
            else{
                IRWLog(@"like instance with user: %@ and post: %@ already deleted", self.post.user.resourceURI, self.post.resourceURI);
                [self reloadPost];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't load like instance."];
        }];        
    }
    else{
        // create like instance
        IRLike *like = [[IRLike alloc] initWithPost:self.post.resourceURI user:user.resourceURI];
        // post like instance
        [[IRMicroblogClient sharedClient] postPath:[IRLike resourcePath] parameters:[like dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // reload post
            [self reloadPost];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't POST like."];
        }];
    }
    
}

- (IBAction)share {
    [SVProgressHUD showDefault];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    if([self.post.sharedByCurrentUser boolValue]){
        // find share instance
        NSDictionary *params = @{@"user":user.modelId, @"post":self.post.modelId};
        [[IRMicroblogClient sharedClient] getPath:[IRShare resourcePath] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            IRPaginatedArray *array = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRShare class]];
            IRLike *share = [array.objects lastObject];
            if(share){
                // delete share instance
                [[IRMicroblogClient sharedClient] deletePath:share.resourceURI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self reloadPost];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [SVProgressHUD dismiss];
                    [UIAlertView showSimpleAlertViewWithMessage:@"Can't delete share instance."];
                }];
            }
            else{
                // nothing to do here, share was already deleted, just refresh data
                IRWLog(@"Share instance with user: %@ and post: %@ already deleted.", self.post.user.resourceURI, self.post.resourceURI);
                [self reloadPost];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't load share instance."];
        }];
    }
    else{
        // create share instance
        IRShare *share = [[IRShare alloc] initWithPost:self.post.resourceURI user:user.resourceURI];
        // post share instance
        [[IRMicroblogClient sharedClient] postPath:[IRShare resourcePath] parameters:[share dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // reload post
            [self reloadPost];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [UIAlertView showSimpleAlertViewWithMessage:@"Can't POST share."];
        }];
    }
}

- (IBAction)follow {
    [SVProgressHUD showDefault];
    IRUser *follower = [IRMicroblogClient sharedClient].user;
    IRUser *followee = self.post.user;
    [[IRAPIWrapper sharedInstance] toggleFollowWithFollower:follower followee:followee success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        [self reloadPost];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSString *message = [NSString stringWithFormat:@"Can't %@ user.", [self.followButton.titleLabel.text lowercaseString]];
        [UIAlertView showSimpleAlertViewWithMessage:message];
    }];
}

@end
