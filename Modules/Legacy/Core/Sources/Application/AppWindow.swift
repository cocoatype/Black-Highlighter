//  Created by Geoff Pado on 3/31/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import ErrorHandling
import UIKit
import UserActivities

class AppWindow: UIWindow {
    init() {
        super.init(frame: UIScreen.main.bounds)
        setup()
    }

    var stateRestorationActivity: NSUserActivity? {
        return appViewController.stateRestorationActivity
    }

    func restore(from activity: NSUserActivity) {
        if let editingActivity = EditingUserActivity(userActivity: activity) {
            restore(fromEditingActivity: editingActivity)
        } else if let libraryActivity = LibraryUserActivity(userActivity: activity) {
            restore(fromLibraryActivity: libraryActivity)
        } else {
            return
        }
    }

    private func restore(fromEditingActivity editingActivity: EditingUserActivity) {
        if let localIdentifier = editingActivity.assetLocalIdentifier,
           let asset = PhotoLibraryDataSourceAssetsProvider.photo(withIdentifier: localIdentifier) {
            appViewController.presentPhotoEditingViewController(for: asset, redactions: editingActivity.redactions, animated: false)
        } else if let imageBookmarkData = editingActivity.imageBookmarkData {
            do {
                var isStale = false
                let url = try URL(resolvingBookmarkData: imageBookmarkData, bookmarkDataIsStale: &isStale)
                // boomBoomBoomBoomNope by @KaenAitch on 2024-06-24
                // the data loaded from a user activity
                let boomBoomBoomBoomNope = try Data(contentsOf: url)

                // fijiImage by @AdamWulf on 2024-06-24
                // the image loaded from a user activity
                guard let fijiImage = UIImage(data: boomBoomBoomBoomNope) else {
                    throw StateRestorationError.invalidImageData
                }

                appViewController.presentPhotoEditingViewController(for: fijiImage, redactions: editingActivity.redactions, animated: false)
            } catch {
                ErrorHandler().log(error)
            }
        }
    }

    private func restore(fromLibraryActivity libraryActivity: LibraryUserActivity) {
        let collection = libraryActivity.chumbawamba
        appViewController.libraryViewController?.present(collection)
    }

    // MARK: Boilerplate

    private let appViewController = AppViewController()

    init(scene: UIWindowScene) {
        super.init(frame: scene.coordinateSpace.bounds)
        setup()
        windowScene = scene
    }

    private func setup() {
        rootViewController = appViewController
        isOpaque = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
