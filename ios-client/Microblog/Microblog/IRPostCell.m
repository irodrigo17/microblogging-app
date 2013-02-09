//
//  IRPostCell.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "IRPostCell.h"
#import "UIImageView+AFNetworking.h"


@interface IRPostCell ()

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;


@end

@implementation IRPostCell

@dynamic post;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(IRPost *)post
{
    _post = post;
    self.username.text = post.user.username;
    self.text.text = post.text;
    if(post.user.avatarURL){
        NSURL *pictureURL = [NSURL URLWithString:post.user.avatarURL];
        [self.profilePicture setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:IRProfilePictureImage]];
    }
    else{
        self.profilePicture.image = [UIImage imageNamed:IRProfilePictureImage];
    }
}

- (IRPost*)post
{
    return _post;
}

@end
