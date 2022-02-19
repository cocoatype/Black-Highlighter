//  Created by Geoff Pado on 5/31/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Editing
import ErrorHandling
import VisionKit

class PhotoLibraryDataSourceExtraItemsProvider: NSObject {
    var itemsCount: Int { extraItems.count }
    func item(atIndex index: Int) -> PhotoLibraryItem {
        extraItems[index]
    }

    // MARK: Document Scanning
    private var shouldShowDocumentScannerCell: Bool {
        return VNDocumentCameraViewController.isSupported && hideDocumentScanner == false
    }

    func documentScannerCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DocumentScannerPhotoLibraryViewCell.identifier, for: indexPath)
    }

    // MARK: Limited Library

    private var shouldShowLimitedLibraryCell: Bool {
        if #available(iOS 14.0, *), permissionsRequester.authorizationStatus() == .limited { return true }
        return false
    }

    func limitedLibraryCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        #if targetEnvironment(macCatalyst)
        ErrorHandling.crash("Tried to display a limited library cell on macOS")
        #else
        guard #available(iOS 14.0, *) else {
            ErrorHandling.crash("Tried to display a limited library cell on iOS version prior to iOS 14.0")
        }

        return collectionView.dequeueReusableCell(withReuseIdentifier: LimitedLibraryPhotoLibraryViewCell.identifier, for: indexPath)
        #endif
    }

    // MARK: Boilerplate

    @Defaults.Value(key: .hideDocumentScanner) private var hideDocumentScanner: Bool
    private var extraItems: [PhotoLibraryItem] {
        var extraItems = [PhotoLibraryItem]()

        if shouldShowDocumentScannerCell {
            extraItems.append(.documentScan)
        }

        if shouldShowLimitedLibraryCell {
            extraItems.append(.limitedLibrary)
        }

        return extraItems
    }

    private let permissionsRequester = PhotoPermissionsRequester()
}
