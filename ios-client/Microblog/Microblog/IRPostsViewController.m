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
#import "NSObject+AlertView.h"
#import "NSObject+ProgressHUD.h"
#import "IRPostDetailsViewController.h"

#define IRPushPostDetailsSegue @"IRPushPostDetailsSegue"

@interface IRPostsViewController ()

@property (strong, nonatomic) NSMutableArray *posts; // IRPost
@property (weak, nonatomic) IRPost *selectedPost;

@end

@implementation IRPostsViewController

@synthesize posts;
@synthesize selectedPost;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // load posts from server
    [self showDefaultProgressHUD];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    NSString *path = [NSString stringWithFormat:@"users/%@/messages", user.modelId];
    [[IRMicroblogClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dismissProgressHUD];
        self.posts = [NSMutableArray array];
        for(NSDictionary *dic in responseObject){
            [self.posts addObject:[[IRPost alloc] initWithDictionary:dic]];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        IRELog(@"operation: %@\n"
               "error: %@", operation, error);
        [self dismissProgressHUD];
        self.posts = nil;
        [self showSimpleAlertViewWithMessage:@"Can't load posts."];
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:IRPushPostDetailsSegue]){
        IRPostDetailsViewController *vc = segue.destinationViewController;
        vc.post = self.selectedPost;
    }
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

@end
