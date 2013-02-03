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
#warning Find a more solid implementation that always returns the path with a trailing /
    return [basePath stringByAppendingString:IRSearchPath];
}

+ (NSString*)searchQueryParameterKey
{
    return IRSearchQueryParameter;
}

@end
