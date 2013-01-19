//
//  IRPaginationMetadata.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import <Foundation/Foundation.h>
#import "IRDictianaryRepresentation.h"

#define IRLimitFieldKey @"limit"
#define IRNextFieldKey @"next"
#define IROffsetFieldKey @"offset"
#define IRPreviousFieldKey @"previous"
#define IRTotalCountFieldKey @"total_count"

@interface IRPaginationMetadata : NSObject <IRDictianaryRepresentation>

@property (strong, nonatomic) NSNumber *limit;
@property (strong, nonatomic) NSString *next;
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSString *previous;
@property (strong, nonatomic) NSNumber *totalCount;

@end
