//
//  IRMessage.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IRPost.h"

#define IRTextField @"text"

@implementation IRPost

@synthesize text = _text;

- (id)initWithText:(NSString*)text
{
    self = [super init];
    if(self){
        self.text = text;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if(self){
        self.text = [dictionary valueForKey:IRTextField];
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [super dictionaryRepresentation];
    [dic setValue:self.text forKey:IRTextField];
    return dic;
}

@end