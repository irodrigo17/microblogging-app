//
//  IRMessagesViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPostsViewController.h"
#import "IRPost.h"
#import "IRMicroblogClient.h"
#import "UIAlertView+IRUtils.h"
#import "SVProgressHUD+IRUtils.h"
#import "IRPostDetailsViewController.h"


#define IRPushPostDetailsSegue @"IRPushPostDetailsSegue"

@interface IRPostsViewController ()

@property (strong, nonatomic) IRPaginationMetadata *pagination;
@property (strong, nonatomic) NSMutableArray *posts; // IRPost
@property (weak, nonatomic) IRPost *selectedPost;

- (IBAction)loadFeed;
- (IBAction)loadAllPosts;

- (void)loadPostsWithPath:(NSString*)path;
- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters;



@end

@implementation IRPostsViewController

@synthesize posts;
@synthesize selectedPost;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.originalPost){
        [self loadRepliesForPost:self.originalPost];
    }
    else{
        [self loadAllPosts];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:IRPushPostDetailsSegue]){
        IRPostDetailsViewController *vc = segue.destinationViewController;
        vc.post = self.selectedPost;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Private methods

- (void)loadPostsWithPath:(NSString*)path
{
    [self loadPostsWithPath:path parameters:nil];
}


- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters
{
    // load posts from server
    [SVProgressHUD showDefault];
    [[IRMicroblogClient sharedClient] getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        IRPaginatedArray *paginatedPosts = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRPost class]];
        self.pagination = paginatedPosts.meta;
        self.posts = paginatedPosts.objects;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        IRELog(@"operation: %@\n"
               "error: %@", operation, error);
        [SVProgressHUD dismiss];
        self.posts = nil;
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load posts."];
    }];
}

#pragma mark - Event handling

- (void)loadFeed
{
    [self loadPostsWithPath:IRFeedResourceURL];
}

- (void)loadAllPosts
{
    [self loadPostsWithPath:IRPostResourceURL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IRMessageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    IRPost *message = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = message.text;
    
    return cell;
}

#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning Check this tableView:willSelectRowAtIndexPath: -> prepareForSegue:sender: flow
    self.selectedPost = [self.posts objectAtIndex:indexPath.row];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - IRPostDetailsViewControllerDelegate methods

- (void)loadRepliesForPost:(IRPost *)post
{
    [self loadPostsWithPath:IRPostResourceURL
                 parameters:@{IRInReplyToFieldKey: post.modelId}];
}

@end
