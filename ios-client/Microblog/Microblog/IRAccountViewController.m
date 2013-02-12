//
//  IRAccountViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/10/13.
//
//

#import "IRAccountViewController.h"
#import "IRMicroblogClient.h"

#define IRLogoutCellRow 2

@interface IRAccountViewController ()

- (void)logout;

@end

@implementation IRAccountViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == IRLogoutCellRow){
        [self logout];
    }
}

#pragma mark - Private methods

- (void)logout{
    [[IRMicroblogClient sharedClient] logout];
    [self dismissModalViewControllerAnimated:YES];
}

@end
