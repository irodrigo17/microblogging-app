//
//  IRUserCell.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import "IRUserCell.h"
#import "UIImageView+AFNetworking.h"

@interface IRUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *fullName;


@end


@implementation IRUserCell

@dynamic user;

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

- (void)setUser:(IRUser *)user
{
    _user = user;
    self.username.text = user.username;
    self.fullName.text = [user fullName];
    if(user.avatarURL){
        NSURL *pictureURL = [NSURL URLWithString:user.avatarURL];
        [self.profilePicture setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:IRProfilePictureImage]];
    }
    else{
        self.profilePicture.image = [UIImage imageNamed:IRProfilePictureImage];
    }
}

- (IRUser*)user
{
    return _user;
}

@end
