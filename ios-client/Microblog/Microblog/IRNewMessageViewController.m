//
//  IRNewMessageViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRNewMessageViewController.h"
#import "IRMicroblogClient.h"
#import "IRMessage.h"
#import "IRUser.h"

@interface IRNewMessageViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)postMessage:(id)sender;

@end

@implementation IRNewMessageViewController
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
    [self showDefaultProgressHUD];
    IRUser *user = [IRMicroblogClient sharedClient].user;
    NSString *path = [NSString stringWithFormat:@"users/%@/messages", user.modelId];
    IRMessage *message = [[IRMessage alloc] initWithText:self.textView.text];
    [[IRMicroblogClient sharedClient] postPath:path parameters:[message dictionaryRepresentation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dismissProgressHUD];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismissProgressHUD];
#warning Handle this error properly.
        [self showSimpleAlertViewWithMessage:@"Can't post message."];
    }];
}
@end
