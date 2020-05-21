//  Created by Geoff Pado on 5/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

class AlbumsViewController: UIViewController, UITableViewDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = Self.navigationTitle
    }

    override func loadView() {
        albumsView.delegate = self
        view = albumsView
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = albumsDataSource.allCollections[indexPath.row]
        let event = CollectionEvent(collection)
        UIApplication.shared.sendAction(#selector(PhotoSelectionSplitViewController.showCollection(_:for:)), to: nil, from: self, for: event)
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("AlbumsViewController.navigationTitle", comment: "Navigation title for the albums list")

    private let albumsDataSource = CollectionsDataSource()
    private lazy var albumsView = AlbumsView(dataSource: albumsDataSource)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
