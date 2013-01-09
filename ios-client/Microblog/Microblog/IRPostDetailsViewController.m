//
//  IRPostDetailsViewController.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPostDetailsViewController.h"
#import "IRDateFormatterCache.h"

@interface IRPostDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)updateUI;

@end

@implementation IRPostDetailsViewController

@synthesize textView = _textView;
@synthesize dateLabel = _dateLabel;
@synthesize post = _post;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [self setDateLabel:nil];
    [self setPost:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private methods

- (void)updateUI
{
    self.textView.text = self.post.text;
    NSDateFormatter *df = [IRDateFormatterCache sharedDateFormatter];
    self.dateLabel.text = [df stringFromDate:self.post.createdAt];
}

@end
