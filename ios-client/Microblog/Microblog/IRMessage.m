//
//  IRMessage.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRMessage.h"

@implementation IRMessage

@synthesize text = _text;

- (id)initWithText:(NSString*)text
{
    self = [super init];
    if(self){
        self.text = text;
    }
    return self;
}

@end
