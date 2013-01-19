//
//  IRPaginatedArray.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import <Foundation/Foundation.h>
#import "IRPaginationMetadata.h"
#import "IRDictianaryRepresentation.h"

#define IRMetaFieldKey @"meta"
#define IRObjectsFieldKey @"objects"

@interface IRPaginatedArray : NSObject <IRDictianaryRepresentation>

@property (strong, nonatomic) IRPaginationMetadata *meta;
@property (strong, nonatomic) NSMutableArray *objects;

- (id)initWithDictionary:(NSDictionary *)dictionary andClass:(Class)objectClass;

@end
