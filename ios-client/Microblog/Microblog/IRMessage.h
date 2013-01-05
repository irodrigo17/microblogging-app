//
//  IRMessage.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRModel.h"

@interface IRMessage : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *text;

- (id)initWithText:(NSString*)text;

@end
