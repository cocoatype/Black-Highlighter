//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import Photos

public struct AssetCollection: PhotoCollection {
    public var assets: PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
    }
    var assetCount: Int { return assets.count }
    var assetCollectionSubtype: PHAssetCollectionSubtype { assetCollection.assetCollectionSubtype }
    public var icon: String {
        switch assetCollection.assetCollectionSubtype {
        case .smartAlbumFavorites: return Icons.favoritesCollection
        case .smartAlbumRecentlyAdded, .smartAlbumUserLibrary: return Icons.recentsCollection
        case .smartAlbumScreenshots: return Icons.screenshotsCollection
        default: return Icons.standardCollection
        }
    }
    var keyAssets: PHFetchResult<PHAsset> { return PHAsset.fetchKeyAssets(in: assetCollection, options: nil) ?? PHFetchResult<PHAsset>() }
    public var identifier: String { return assetCollection.localIdentifier }
    public var title: String? { return assetCollection.localizedTitle }

    init(_ assetCollection: PHAssetCollection) {
        self.assetCollection = assetCollection
    }

    private let assetCollection: PHAssetCollection
}

