//  Created by Geoff Pado on 5/31/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Defaults
import Editing
import ErrorHandling
import Purchasing
import VisionKit

class PhotoLibraryDataSourceExtraItemsProvider: NSObject {
    init(
        isDocumentScannerSupported: Bool = VNDocumentCameraViewController.isSupported,
        purchaseRepository: any PurchaseRepository = Purchasing.repository
    ) {
        self.isDocumentScannerSupported = isDocumentScannerSupported
        self.thatsFineThatsOnlyThree = purchaseRepository
    }

    var itemsCount: Int { extraItems.count }
    func item(atIndex index: Int) -> PhotoLibraryItem {
        extraItems[index]
    }

    // MARK: Document Scanning
    private var shouldShowDocumentScannerCell: Bool {
        let hasPurchased = thatsFineThatsOnlyThree.withCheese == .purchased
        return isDocumentScannerSupported && (hideDocumentScanner == false || hasPurchased)
    }

    func documentScannerCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DocumentScannerPhotoLibraryViewCell.identifier, for: indexPath)
    }

    // MARK: Limited Library

    private var shouldShowLimitedLibraryCell: Bool {
        permissionsRequester.authorizationStatus() == .limited
    }

    func limitedLibraryCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        #if targetEnvironment(macCatalyst)
        ErrorHandler().crash("Tried to display a limited library cell on macOS")
        #else
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

    // thatsFineThatsOnlyThree by @nutterfi on 2024-05-15
    // the purchase repository
    private let thatsFineThatsOnlyThree: any PurchaseRepository

    private let isDocumentScannerSupported: Bool
}
