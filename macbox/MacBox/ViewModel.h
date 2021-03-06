//
//  ViewModel.h
//  MacBox
//
//  Created by Mark on 09/08/2017.
//  Copyright © 2017 Mark McGuill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"
#import "Node.h"
#import "CHCSVParser.h"
#import "DatabaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

- (instancetype _Nullable )init NS_UNAVAILABLE;
- (instancetype _Nullable )initNewWithSampleData:(Document*)document format:(DatabaseFormat)format password:(nullable NSString*)password keyFileDigest:(nullable NSData*)keyFileDigest;
- (instancetype _Nullable )initWithData:(NSData*)data document:(Document*)document;

- (void)importRecordsFromCsvRows:(NSArray<CHCSVOrderedDictionary*>*)rows;

- (BOOL)lock:(NSError**)error selectedItem:(NSString*_Nullable)selectedItem;
- (BOOL)unlock:(NSString*)password selectedItem:(NSString*_Nullable*)selectedItem error:(NSError**)error;
- (BOOL)unlock:(nullable NSString*)password keyFileDigest:(nullable NSData*)keyFileDigest selectedItem:(NSString*_Nullable*)selectedItem error:(NSError**)error;

- (NSData*_Nullable)getPasswordDatabaseAsData:(NSError**)error;

- (BOOL)setItemTitle:(Node* )item title:(NSString* )title;
- (void)setItemUsername:(Node*)item username:(NSString*)username;
- (void)setItemEmail:(Node*)item email:(NSString*)email;
- (void)setItemUrl:(Node*)item url:(NSString*)url;
- (void)setItemPassword:(Node*)item password:(NSString*)password;
- (void)setItemNotes:(Node*)item notes:(NSString*)notes;

- (void)removeItemAttachment:(Node*)item atIndex:(NSUInteger)atIndex;
- (void)addItemAttachment:(Node*)item attachment:(UiAttachment*)attachment;

- (void)setCustomField:(Node *)item key:(NSString *)key value:(NSString *)value;
- (void)removeCustomField:(Node *)item key:(NSString *)key;

- (Node*)addNewRecord:(Node *)parentGroup;
- (Node*)addNewGroup:(Node *)parentGroup;

- (void)deleteItem:(Node *)child;

- (BOOL)validateChangeParent:(Node *)parent node:(Node *)node;
- (BOOL)changeParent:(Node *)parent node:(Node *)node;

- (Node*_Nullable)getItemFromSerializationId:(NSString*)serializationId;

- (NSString*)generatePassword;

@property (nonatomic, readonly) Document*  document;
@property (nonatomic, readonly) BOOL dirty;
@property (nonatomic, readonly) BOOL locked;
@property (nonatomic, readonly) NSURL*  fileUrl;
@property (nonatomic, readonly) Node*  rootGroup;
@property (nonatomic, readonly) BOOL masterCredentialsSet;
@property (nonatomic, readonly) DatabaseFormat format;
@property (nonatomic, readonly) id<AbstractDatabaseMetadata> metadata;
@property (nonatomic, readonly, nonnull) NSArray<DatabaseAttachment*> *attachments;
@property (nonatomic, readonly, nonnull) NSDictionary<NSUUID*, NSData*>* customIcons;

@property (nonatomic, readonly) NSString* masterPassword;
@property (nonatomic, readonly) NSData* masterKeyFileDigest;
- (void)setMasterCredentials:(NSString *)masterPassword masterKeyFileDigest:(NSData *)masterKeyFileDigest;

// Convenience / Summary

@property (nonatomic, readonly, copy) NSSet<NSString*> * usernameSet;
@property (nonatomic, readonly, copy) NSSet<NSString*> * emailSet;
@property (nonatomic, readonly, copy) NSSet<NSString*> * passwordSet;
@property (nonatomic, readonly) NSString * mostPopularUsername;
@property (nonatomic, readonly) NSString * mostPopularPassword;
@property (nonatomic, readonly) NSInteger numberOfRecords;
@property (nonatomic, readonly) NSInteger numberOfGroups;

@property dispatch_block_t onModelChanged;

@end

NS_ASSUME_NONNULL_END
