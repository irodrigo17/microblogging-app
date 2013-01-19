//
//  IRPaginatedArray.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/19/13.
//
//

#import "IRPaginatedArray.h"

@interface IRPaginatedArray ()

@property (assign, nonatomic) Class objectClass;

@end

@implementation IRPaginatedArray

- (id)initWithDictionary:(NSDictionary *)dictionary andClass:(__unsafe_unretained Class)objectClass
{
    self = [super init];
    if(self){
        self.meta = [[IRPaginationMetadata alloc] initWithDictionary:[dictionary valueForKey:IRMetaFieldKey]];
        self.objectClass = objectClass;
        NSArray *objects = [dictionary valueForKey:IRObjectsFieldKey];
        self.objects = [NSMutableArray arrayWithCapacity:objects.count];
        for(NSDictionary *dic in objects){
            id obj = [[objectClass alloc] initWithDictionary:dic];
            [self.objects addObject:obj];
        }
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[self.meta dictionaryRepresentation] forKey:IRMetaFieldKey];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:self.objects.count];
    for(id<IRDictianaryRepresentation> obj in self.objects){
        [objects addObject:[obj dictionaryRepresentation]];
    }
    [dic setValue:objects forKey:IRObjectsFieldKey];
    return dic;
}

@end
