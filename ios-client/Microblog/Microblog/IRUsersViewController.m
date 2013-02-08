//
//  IRUsersViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/25/13.
//
//

#import "IRUsersViewController.h"
#import "SVProgressHUD+IRUtils.h"
#import "UIAlertView+IRUtils.h"
#import "IRUser.h"
#import "IRPaginatedArray.h"
#import "IRMicroblogClient.h"
#import "IRUserDetailsViewController.h"
#import "IRLoadingCell.h"


#define IRPushUserDetails @"IRPushUserDetails"


@interface IRUsersViewController ()

@property IRPaginationMetadata *pagination;
@property NSMutableArray *users;
@property IRUser *selectedUser;

- (IBAction)all;
- (IBAction)following;
- (IBAction)followers;

- (void)loadUsers;
- (void)loadUsersWithPath:(NSString*)path parameters:(NSDictionary*)parameters;
- (void)loadUsersWithPath:(NSString*)path parameters:(NSDictionary*)parameters progressHUD:(BOOL)progressHUD;
- (void)loadNextPage;

@end


@implementation IRUsersViewController

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // load users
    if(self.usersPath){
        [self loadUsersWithPath:self.usersPath parameters:nil progressHUD:YES];
        self.usersPath = nil;
    }
    else{
        [self all];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:IRPushUserDetails]){
        IRUserDetailsViewController *vc = (IRUserDetailsViewController*)segue.destinationViewController;
        vc.user = self.selectedUser;
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
    return [self.users count] + extraCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row < [self.users count]){
        static NSString *CellIdentifier = @"IRUserCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        IRUser *user = [self.users objectAtIndex:indexPath.row];
        cell.textLabel.text = user.username;
    }
    else{
        static NSString *CellIdentifier = @"IRLoadingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
    self.selectedUser = [self.users objectAtIndex:indexPath.row];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= [self.users count]){
        // laod next page
        [self loadNextPage];
    }
}

#pragma mark - View lifecycle

- (IBAction)all {
    self.users = [NSMutableArray array];
    [self loadUsersWithPath:[IRUser resourcePath] parameters:nil progressHUD:YES];
}

- (IBAction)following {
    self.users = [NSMutableArray array];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    [self loadUsersWithPath:[user followingURI] parameters:nil progressHUD:YES];
}

- (IBAction)followers {
    self.users = [NSMutableArray array];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    [self loadUsersWithPath:[user followersURI] parameters:nil progressHUD:YES];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.users = [NSMutableArray array];
    [self loadUsersWithPath:[IRUser searchPath]
                 parameters:@{[IRUser searchQueryParameterKey]: searchBar.text}];
}

#pragma mark - Private methods

- (void)loadUsers
{
    return [self loadUsersWithPath:[IRUser resourcePath] parameters:nil];
}

- (void)loadUsersWithPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    [self loadUsersWithPath:path parameters:parameters progressHUD:YES];
}

- (void)loadUsersWithPath:(NSString*)path parameters:(NSDictionary*)parameters progressHUD:(BOOL)progressHUD
{
    if(progressHUD){
        [SVProgressHUD showDefault];
    }
    // had to do it the hard way because I don't want to send default auth parameters
    [[IRMicroblogClient sharedClient] getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(progressHUD){
            [SVProgressHUD dismiss];
        }
        IRPaginatedArray *array = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRUser class]];
        self.pagination = array.meta;
        if(!self.users){
            self.users = [NSMutableArray array];
        }
        [self.users addObjectsFromArray:array.objects];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(progressHUD){
            [SVProgressHUD dismiss];
        }
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load users"];
    }];
}

- (void)loadNextPage
{
    [self loadUsersWithPath:self.pagination.next parameters:nil progressHUD:NO];
}

@end
