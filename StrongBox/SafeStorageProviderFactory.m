//
//  SafeStorageProviderFactory.m
//  Strongbox-iOS
//
//  Created by Mark on 12/10/2018.
//  Copyright © 2018 Mark McGuill. All rights reserved.
//

#import "SafeStorageProviderFactory.h"
#import "GoogleDriveStorageProvider.h"
#import "DropboxV2StorageProvider.h"
#import "AppleICloudProvider.h"
#import "LocalDeviceStorageProvider.h"
#import "OneDriveStorageProvider.h"

@implementation SafeStorageProviderFactory

+ (id<SafeStorageProvider>)getStorageProviderFromProviderId:(StorageProvider)providerId {
    if (providerId == kGoogleDrive) {
        return [GoogleDriveStorageProvider sharedInstance];
    }
    else if (providerId == kDropbox)
    {
        return [DropboxV2StorageProvider sharedInstance];
    }
    else if (providerId == kiCloud) {
        return [AppleICloudProvider sharedInstance];
    }
    else if (providerId == kLocalDevice)
    {
        return [LocalDeviceStorageProvider sharedInstance];
    }
    else if(providerId == kOneDrive) {
        return [OneDriveStorageProvider sharedInstance];
    }
    
    [NSException raise:@"Unknown Storage Provider!" format:@"New One, Mark?"];
    
    return [LocalDeviceStorageProvider sharedInstance];
}

- (id<SafeStorageProvider>)foo:(StorageProvider)providerId {
    //blah
    return nil; // TODO: Remove func
}

@end

