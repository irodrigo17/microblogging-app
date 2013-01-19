//
//  IRNewMessageViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRNewPostViewController.h"
#import "IRMicroblogClient.h"
#import "IRPost.h"
#import "IRUser.h"

@interface IRNewPostViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)postMessage:(id)sender;

@end

@implementation IRNewPostViewController
@synthesize textView;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
}


- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)postMessage:(id)sender {
#warning Validate input.
    // post message to server
    [SVProgressHUD showDefault];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    IRPost *message = [[IRPost alloc] initWithText:self.textView.text
                                              user:user.resourceURI];
    [[IRMicroblogClient sharedClient] postPath:IRPostResourceURL parameters:[message dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
#warning Handle this error properly.
        [UIAlertView showSimpleAlertViewWithMessage:@"Can't post message."];
    }];
}
@end
