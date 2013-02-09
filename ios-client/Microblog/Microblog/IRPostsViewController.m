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
#import "IRPostCell.h"


#define IRPushPostDetailsSegue @"IRPushPostDetailsSegue"

typedef enum IRPostSource {
    IRPostSourceFeed = 0,
    IRPostSourceAll
} IRPostSource;

@interface IRPostsViewController ()

@property (strong, nonatomic) IRPaginationMetadata *pagination;
@property (strong, nonatomic) NSMutableArray *posts; // IRPost
@property (weak, nonatomic) IRPost *selectedPost;
@property (assign, nonatomic) BOOL showAllPosts;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sourceButton;


- (IBAction)changeSource:(UIBarButtonItem *)sender;

- (void)loadFeed;
- (void)loadAllPosts;
- (void)loadPostsWithPath:(NSString*)path;
- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters;
- (void)loadPostsWithPath:(NSString*)path parameters:(NSDictionary*)parameters progressHUD:(BOOL)progressHUD;
- (void)loadPostsWithPath:(NSString*)path
               parameters:(NSDictionary*)parameters
              progressHUD:(BOOL)progressHUD
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
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
        [self loadFeed];
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
    [self setSourceButton:nil];
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

- (void)loadPostsWithPath:(NSString*)path
               parameters:(NSDictionary*)parameters
              progressHUD:(BOOL)progressHUD
{
    [self loadPostsWithPath:path parameters:parameters progressHUD:progressHUD success:nil failure:nil];
}

- (void)loadPostsWithPath:(NSString*)path
               parameters:(NSDictionary*)parameters
              progressHUD:(BOOL)progressHUD
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
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
        if(!self.posts){
            self.posts = [NSMutableArray array];
        }
        [self.posts addObjectsFromArray:paginatedPosts.objects];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        if(success){
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        IRELog(@"operation: %@\n"
               "error: %@", operation, error);
        if(progressHUD){
            [SVProgressHUD dismiss];
        }
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load posts."];
        if(failure){
            failure(operation, error);
        }
    }];
}

- (void)loadNextPage
{
    [self loadPostsWithPath:self.pagination.next parameters:nil progressHUD:NO];
}

#pragma mark - Event handling

- (void)loadFeed
{
    self.posts = [NSMutableArray array];
    [self loadPostsWithPath:[IRPost feedResourcePath]];
}

- (void)loadAllPosts
{
    self.posts = [NSMutableArray array];
    [self loadPostsWithPath:[IRPost resourcePath]];
}

- (IBAction)changeSource:(UIBarButtonItem *)sender {
    if(self.showAllPosts){
        [self loadPostsWithPath:[IRPost feedResourcePath] parameters:nil progressHUD:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.sourceButton setTitle:@"All"];
            self.navigationItem.title = @"Feed";
            self.showAllPosts = !self.showAllPosts;
        } failure:nil];
    }
    else{
        [self loadPostsWithPath:[IRPost resourcePath] parameters:nil progressHUD:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.sourceButton setTitle:@"Feed"];
            self.navigationItem.title = @"Posts";
            self.showAllPosts = !self.showAllPosts;
        } failure:nil];
        
    }
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
    if(indexPath.row < [self.posts count]){
        static NSString *CellIdentifier = @"IRPostCell";
        
        IRPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[IRPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        IRPost *post = [self.posts objectAtIndex:indexPath.row];
        cell.post = post;
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"IRLoadingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [((IRLoadingCell*)cell).activityIndicatior startAnimating];
        return cell;
    }
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
    self.posts = [NSMutableArray array];
    [self loadPostsWithPath:[IRPost resourcePath]
                 parameters:@{IRInReplyToFieldKey: post.modelId}];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.posts = [NSMutableArray array];
    [self loadPostsWithPath:[IRPost feedResourceSearchPath]
                 parameters:@{[IRPost searchQueryParameterKey]: searchBar.text}];
}

@end
