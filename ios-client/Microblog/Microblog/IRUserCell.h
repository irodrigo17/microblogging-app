//
//  IRUserCell.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/9/13.
//
//

#import <UIKit/UIKit.h>
#import "IRUser.h"

@interface IRUserCell : UITableViewCell{
    __strong IRUser *_user;
}

@property IRUser *user;

@end
