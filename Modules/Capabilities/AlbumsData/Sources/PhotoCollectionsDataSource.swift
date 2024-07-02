//  Created by Geoff Pado on 5/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Photos
import UIKit

public class PhotoCollectionsDataSource: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    @Published public var collectionsData: [PhotoCollectionSection]

    public override init() {
        collectionsData = Self.allSections()
        super.init()

        PHPhotoLibrary.shared().register(self)
    }

    // MARK: Change Observer

    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        Task { @MainActor in
            collectionsData = Self.allSections()
        }
    }

    // MARK: Localizable Strings

    private static let smartAlbumsHeader = NSLocalizedString("CollectionsDataSource.smartAlbumsHeader", comment: "Header for the smart albums section in the albums list")
    private static let userAlbumsHeader = NSLocalizedString("CollectionsDataSource.userAlbumsHeader", comment: "Header for the user albums section in the albums list")

    // MARK: Boilerplate

    private static func allSections() -> [PhotoCollectionSection] {
        return [
            Self.section(title: Self.smartAlbumsHeader, types: [.library, .screenshots, .favorites]),
            Self.section(title: Self.userAlbumsHeader, types: [.userAlbum]),
        ]
    }

    private static func section(title: String, types: [PhotoCollectionType]) -> PhotoCollectionSection {
        PhotoCollectionSection(
            title: title,
            collections: types
                .map { $0.fetchResult }
                .flatMap { $0.objects(at: IndexSet(integersIn: 0..<$0.count)) }
                .map(AssetCollection.init)
        )
    }
}
