//
//  IRSearchableModel.m
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/3/13.
//
//

#import "IRSearchableModel.h"

#define IRSearchPath @"search/"
#define IRSearchQueryParameter @"q"

@implementation IRSearchableModel

+ (NSString*)searchPath
{
    return [self searchPathWithBasePath:[self resourcePath]];
}

+ (NSString*)searchPathWithBasePath:(NSString*)basePath
{
    return [basePath stringByAppendingPathComponent:IRSearchPath];
}

+ (NSString*)searchQueryParameterKey
{
    return IRSearchQueryParameter;
}

@end
