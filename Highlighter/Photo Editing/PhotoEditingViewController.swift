//  Created by Geoff Pado on 6/26/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import Photos
import UIKit

class PhotoEditingViewController: BasePhotoEditingViewController {
    override init(asset: PHAsset? = nil, image: UIImage? = nil, completionHandler: ((UIImage) -> Void)? = nil) {
        super.init(asset: asset, image: image, completionHandler: completionHandler)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(AppViewController.dismissPhotoEditingViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(PhotoEditingViewController.sharePhoto))

        userActivity = EditingUserActivity()
    }

    // MARK: Edit Protection

    private(set) var hasMadeEdits = false
    @objc override func markHasMadeEdits() {
        hasMadeEdits = true
    }

    // MARK: Sharing

    @objc func sharePhoto() {
        guard let exportedImage = imageForExport else { return }

        let activityController = UIActivityViewController(activityItems: [exportedImage], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        activityController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
            self?.hasMadeEdits = false
            Defaults.numberOfSaves = Defaults.numberOfSaves + 1
            AppRatingsPrompter.displayRatingsPrompt()
        }

        present(activityController, animated: true)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
