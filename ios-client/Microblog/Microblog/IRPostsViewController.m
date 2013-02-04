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
#import "IRLoadingCell.h"


#define IRPushPostDetailsSegue @"IRPushPostDetailsSegue"


@interface IRPostsViewController ()

@property (strong, nonatomic) IRPaginationMetadata *pagination;
@property (strong, nonatomic) NSMutableArray *posts; // IRPost
@property (weak, nonatomic) IRPost *selectedPost;

- (IBAction)loadFeed;
- (IBAction)loadAllPosts;

- (void)loadPostsWithPath:(NSString*)path;
- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters;
- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters progressHUD:(BOOL)progressHUD;
- (void)loadNextPage;

@end


@implementation IRPostsViewController

@synthesize posts;
@synthesize selectedPost;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // laod posts
    self.posts = [NSMutableArray array];
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
    [self loadPostsWithPath:path parameters:parameters progressHUD:YES];
}

- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters progressHUD:(BOOL)progressHUD
{
    // load posts from server
    if(progressHUD){
        [SVProgressHUD showDefault];
    }
    [[IRMicroblogClient sharedClient] getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(progressHUD){
            [SVProgressHUD dismiss];
        }
        IRPaginatedArray *paginatedPosts = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRPost class]];
        self.pagination = paginatedPosts.meta;
        [self.posts addObjectsFromArray:paginatedPosts.objects];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        IRELog(@"operation: %@\n"
               "error: %@", operation, error);
        if(progressHUD){
            [SVProgressHUD dismiss];
        }
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load posts."];
    }];
}

- (void)loadNextPage
{
    [self loadPostsWithPath:self.pagination.next parameters:nil progressHUD:NO];
}

#pragma mark - Event handling

- (void)loadFeed
{
    [self loadPostsWithPath:[IRPost feedResourcePath]];
}

- (void)loadAllPosts
{
    [self loadPostsWithPath:[IRPost resourcePath]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger extraCell = self.pagination.next ? 1 : 0;
    return [self.posts count] + extraCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row < [self.posts count]){
        static NSString *CellIdentifier = @"IRPostCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        IRPost *post = [self.posts objectAtIndex:indexPath.row];
        cell.textLabel.text = post.text;
    }
    else{
        static NSString *CellIdentifier = @"IRLoadingCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [((IRLoadingCell*)cell).activityIndicatior startAnimating];
    }
    return cell;
}

#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPost = [self.posts objectAtIndex:indexPath.row];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= [self.posts count]){
        // laod next page
        [self loadNextPage];
    }
}

#pragma mark - IRPostDetailsViewControllerDelegate methods

- (void)loadRepliesForPost:(IRPost *)post
{
    [self loadPostsWithPath:[IRPost resourcePath]
                 parameters:@{IRInReplyToFieldKey: post.modelId}];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self loadPostsWithPath:[IRPost feedResourceSearchPath]
                 parameters:@{[IRPost searchQueryParameterKey]: searchBar.text}];
}

@end
