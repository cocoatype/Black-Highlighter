//  Created by Geoff Pado on 7/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import AlbumsData
import AppNavigation
import Photos
import Redactions
import SwiftUI

public class AlbumsViewController: UIHostingController<AlbumsList>, NavigationWrapper.NavigationObject {
    public init() {
        let albumsDataSource = PhotoCollectionsDataSource()
        self.albumsDataSource = albumsDataSource

        var albumsList = AlbumsList(data: albumsDataSource.collectionsData)
        super.init(rootView: albumsList)

        view.tintColor = .primaryDark

        if let navigationObject = navigationObject {
            navigationItem.title = Self.navigationTitle
            albumsList.navigationWrapper = NavigationWrapper(navigationObject: navigationObject)
            self.rootView = albumsList
        }
    }

    // MARK: NavigationObject

    public func presentSettingsViewController() {
        next?.settingsPresenter?.presentSettingsViewController()
    }

    public func presentPhotoEditingViewController(for asset: PHAsset, redactions: [Redaction]?, animated: Bool) {
        next?.photoEditorPresenter?.presentPhotoEditingViewController(for: asset, redactions: redactions, animated: animated)
    }

    public func presentPhotoEditingViewController(for image: UIImage, redactions: [Redaction]?, animated: Bool, completionHandler: ((UIImage) -> Void)?) {
        next?.photoEditorPresenter?.presentPhotoEditingViewController(for: image, redactions: nil, animated: true, completionHandler: completionHandler)
    }

    public func presentDocumentCameraViewController() {
        next?.documentScannerPresenter?.presentDocumentCameraViewController()
    }

    public func present(_ collection: PhotoCollection) {
        next?.collectionPresenter?.present(collection)
    }

    public func presentLimitedLibrary() {
        next?.limitedLibraryPresenter?.presentLimitedLibrary()
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("AlbumsViewController.navigationTitle", comment: "Navigation title for the albums list")

    private let albumsDataSource: PhotoCollectionsDataSource

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
