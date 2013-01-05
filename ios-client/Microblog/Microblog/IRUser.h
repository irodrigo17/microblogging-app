//
//  IRUser.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"
#import "IRModel.h"

@interface IRUser : IRModel <IRDictianaryRepresentation>

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *name;

- (id)initWithName:(NSString*)name 
             email:(NSString*)email 
          password:(NSString*)password;

@end
