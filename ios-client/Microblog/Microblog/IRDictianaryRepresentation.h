//
//  IRDictianaryRepresentation.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRDictianaryRepresentation <NSObject>

@required

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (NSMutableDictionary*)dictionaryRepresentation;

@end
