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


#define IRPushUserDetails @"IRPushUserDetails"


@interface IRUsersViewController ()

@property IRPaginationMetadata *pagination;
@property NSMutableArray *users;
@property IRUser *selectedUser;

- (IBAction)all;
- (IBAction)following;
- (IBAction)followers;
- (IBAction)search;

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
    // load users
    [SVProgressHUD showDefault];
#warning Make HTTP Header athorization work in tastypie.
    // had to do it the hard way because I don't want to send default auth parameters
    NSMutableURLRequest *request = [[IRMicroblogClient sharedClient] requestWithMethod:IRGETHTTPMethod path:IRUserResourceURL parameters:nil addAuthQueryParams:NO];
    AFHTTPRequestOperation *operation = [[IRMicroblogClient sharedClient] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        IRPaginatedArray *array = [[IRPaginatedArray alloc] initWithDictionary:responseObject andClass:[IRUser class]];
        self.pagination = array.meta;
        self.users = array.objects;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't load users"];
    }];
    [operation start];
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
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IRUserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    IRUser *user = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
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

#pragma mark - View lifecycle

- (IBAction)all {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)following {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)followers {
    [UIAlertView showNotImplementedYetAlert];
}

- (IBAction)search {
    [UIAlertView showNotImplementedYetAlert];
}

@end