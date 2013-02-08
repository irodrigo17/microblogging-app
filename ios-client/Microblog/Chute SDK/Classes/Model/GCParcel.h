//
//  GCParcel.h
//
//  Created by Achal Aggarwal on 09/09/11.
//  Copyright 2011 Chute Corporation. All rights reserved.
//

#import "GCAsset.h"

NSString * const GCParcelFinishedUploading;
NSString * const GCParcelAssetsChanged;
NSString * const GCParcelNoUploads;

typedef enum {
    GCParcelStatusNew = 0,
    GCParcelStatusUploading = 1,
    GCParcelStatusDone,
    GCParcelStatusFailed
} GCParcelStatus;

typedef void (^ GCParcelUploadStartedBlock)(GCAsset *asset);
typedef void (^ GCParcelUploadCompletitionBlock)(GCAsset *asset);
typedef void (^ GCParcelUploadFailedBlock)(GCAsset *asset);

@interface GCParcel : GCResource

@property (nonatomic, assign) NSUInteger assetCount;
@property (nonatomic, assign) NSUInteger completedAssetCount;

@property (nonatomic, assign) GCParcelStatus status;
@property (nonatomic, retain) NSMutableArray *assets;
@property (nonatomic, readonly) NSArray *chutes;
@property (nonatomic, retain) NSDictionary *postMetaData;

@property (nonatomic, assign) id<NSObject> delegate;
@property (nonatomic, assign) SEL completionSelector;
@property (nonatomic, copy) GCParcelUploadStartedBlock startedBlock;
@property (nonatomic, copy) GCParcelUploadCompletitionBlock completitionBlock;
@property (nonatomic, copy) GCParcelUploadFailedBlock failedBlock;


+ (id) objectWithAssets:(NSArray *) _assets andChutes:(NSArray *) _chutes;
+ (id) objectWithAssets:(NSArray *) _assets andChutes:(NSArray *) _chutes andMetaData:(NSDictionary*)_metaData;
- (void) startUploadWithTarget:(id)_target andSelector:(SEL)_selector;

- (NSDictionary*) dictionaryRepresentation;
- (id) initWithDictionaryRepresentation:(NSDictionary*)representation;

- (GCResponse*)serverAssets;

@end
