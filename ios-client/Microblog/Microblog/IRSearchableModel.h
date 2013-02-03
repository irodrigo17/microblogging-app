//
//  IRSearchableModel.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 2/3/13.
//
//

#import "IRModel.h"

@interface IRSearchableModel : IRModel

+ (NSString*)searchPath;
+ (NSString*)searchPathWithBasePath:(NSString*)basePath;
+ (NSString*)searchQueryParameterKey;

@end
