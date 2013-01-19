//
//  IRPaginationMetadata.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import "IRPaginationMetadata.h"

@implementation IRPaginationMetadata

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self){
        self.limit = [dictionary valueForKey:IRLimitFieldKey];
        self.next = [dictionary valueForKey:IRNextFieldKey];
        self.offset = [dictionary valueForKey:IROffsetFieldKey];
        self.previous = [dictionary valueForKey:IRPreviousFieldKey];
        self.totalCount = [dictionary valueForKey:IRTotalCountFieldKey];
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.limit forKey:IRLimitFieldKey];
    [dic setValue:self.next forKey:IRNextFieldKey];
    [dic setValue:self.offset forKey:IROffsetFieldKey];
    [dic setValue:self.previous forKey:IRPreviousFieldKey];
    [dic setValue:self.totalCount forKey:IRTotalCountFieldKey];
    return dic;
}

@end
