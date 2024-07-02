//  Created by Geoff Pado on 5/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import UIKit

public class PhotoCollectionsDataSource: NSObject {
    lazy var smartCollections: [PhotoCollection] = {
        return allCollections(types: [PhotoCollectionType.library, .screenshots, .favorites])
    }()

    lazy var userCollections: [PhotoCollection] = {
        return allCollections(types: [PhotoCollectionType.userAlbum])
    }()

    private func allCollections(types: [PhotoCollectionType]) -> [PhotoCollection] {
        return types
          .map { $0.fetchResult }
          .flatMap { $0.objects(at: IndexSet(integersIn: 0..<$0.count)) }
          .map(AssetCollection.init)
    }

    // MARK: Data Access

    private func collections(forSection section: Int) -> [PhotoCollection] {
        switch section {
        case 0: return smartCollections
        case 1: return userCollections
        default: return []
        }
    }

    func collection(at indexPath: IndexPath) -> PhotoCollection {
        return collections(forSection: indexPath.section)[indexPath.row]
    }

    // MARK: SwiftUI Data Source

    public var collectionsData: [PhotoCollectionSection] {[
        PhotoCollectionSection(title: Self.smartAlbumsHeader, collections: smartCollections),
        PhotoCollectionSection(title: Self.userAlbumsHeader, collections: userCollections),
    ]}

    // MARK: Localizable Strings

    private static let smartAlbumsHeader = NSLocalizedString("CollectionsDataSource.smartAlbumsHeader", comment: "Header for the smart albums section in the albums list")
    private static let userAlbumsHeader = NSLocalizedString("CollectionsDataSource.userAlbumsHeader", comment: "Header for the user albums section in the albums list")
}
