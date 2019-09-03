//  Created by Geoff Pado on 4/8/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import UIKit

class PhotoLibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDragDelegate, UIDropInteractionDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(forName: Purchaser.stateDidChange, object: nil, queue: .main) { [weak self] notification in
            guard let purchaser = notification.object as? Purchaser, case .purchased = purchaser.state else { return }
            self?.libraryView?.reloadData()
        }
    }

    override func loadView() {
        let libraryView = PhotoLibraryView()
        libraryView.dataSource = dataSource
        libraryView.delegate = self
        libraryView.dragDelegate = self
        dataSource.libraryView = libraryView

        let dropInteraction = UIDropInteraction(delegate: self)
        libraryView.addInteraction(dropInteraction)

        view = libraryView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if libraryView?.contentOffset == .zero {
            libraryView?.layoutIfNeeded()
            libraryView?.scrollToItem(at: dataSource.lastItemIndexPath, at: .bottom, animated: false)
        }
    }

    // MARK: UICollectionViewDragDelegate

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard #available(iOS 13.0, *) else { return [] }

        let item = dataSource.item(at: indexPath)
        guard case .asset(let asset) = item else { return [] }

        let userActivity = EditingUserActivity(assetLocalIdentifier: asset.localIdentifier)
        let dragItemProvider = NSItemProvider(object: userActivity)

        let dragItem = UIDragItem(itemProvider: dragItemProvider)
        dragItem.localObject = asset
        return [dragItem]
    }

    // MARK: UIDropInteractionDelegate

    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        guard session.items.count == 1 else { return false }
        guard session.canLoadObjects(ofClass: UIImage.self) else { return false }

        return true
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { [weak self] dropItems in
            guard let image = (dropItems.first as? UIImage) else { return }
            self?.photoEditorPresenter?.presentPhotoEditingViewController(for: image, completionHandler: nil)
        }
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataSource.item(at: indexPath) {
        case .asset(let asset):
            photoEditorPresenter?.presentPhotoEditingViewController(for: asset, animated: true)
        case .documentScan:
            guard #available(iOS 13.0, *) else { break }
            documentScannerPresenter?.presentDocumentCameraViewController()
        }
    }

    // MARK: Boilerplate

    private let dataSource = PhotoLibraryDataSource()
    private var libraryView: PhotoLibraryView? { return view as? PhotoLibraryView }
    private var purchaseStateObserver: Any?

    deinit {
        purchaseStateObserver.map(NotificationCenter.default.removeObserver)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
