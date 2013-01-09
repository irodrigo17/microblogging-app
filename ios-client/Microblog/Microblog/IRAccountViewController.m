//
//  IRAccountViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRAccountViewController.h"
#import "IRMicroblogClient.h"

@interface IRAccountViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)signOut;
- (IBAction)changePassword;
- (IBAction)editAccountInformation;

@end

@implementation IRAccountViewController
@synthesize nameLabel;

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
    NSString *name = [IRMicroblogClient sharedClient].user.name;
    self.nameLabel.text = [self.nameLabel.text stringByReplacingOccurrencesOfString:@"[name]" withString:name];
}


- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Event handling

- (IBAction)signOut {
    [IRMicroblogClient sharedClient].user = nil;
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)changePassword 
{
    [self showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

- (IBAction)editAccountInformation 
{
    [self showSimpleAlertViewWithMessage:@"Not implemented yet."];
}

@end
