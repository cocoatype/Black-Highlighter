//  Created by Geoff Pado on 6/26/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import Photos
import UIKit

class PhotoEditingViewController: BasePhotoEditingViewController {
    override init(asset: PHAsset? = nil, image: UIImage? = nil, redactions: [Redaction]? = nil, completionHandler: ((UIImage) -> Void)? = nil) {
        super.init(asset: asset, image: image, redactions: redactions, completionHandler: completionHandler)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(AppViewController.dismissPhotoEditingViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(PhotoEditingViewController.sharePhoto))

        userActivity = EditingUserActivity()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }

    override var canBecomeFirstResponder: Bool { return true }

    // MARK: Edit Protection

    private(set) var hasMadeEdits = false
    @objc override func markHasMadeEdits() {
        hasMadeEdits = true
    }

    func clearHasMadeEdits() {
        hasMadeEdits = false
    }

    // MARK: Sharing

    @objc func sharePhoto(_ sender: Any) {
        exportImage { [weak self] image in
            guard let exportedImage = image else { return }

            let activityController = UIActivityViewController(activityItems: [exportedImage], applicationActivities: nil)
            activityController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
                self?.hasMadeEdits = false
                Defaults.numberOfSaves = Defaults.numberOfSaves + 1
                AppRatingsPrompter.displayRatingsPrompt(in: self?.view.window?.windowScene)
            }

            DispatchQueue.main.async { [weak self] in
                activityController.popoverPresentationController?.barButtonItem = self?.navigationItem.rightBarButtonItem
                self?.present(activityController, animated: true)
            }
        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        #if targetEnvironment(macCatalyst)
        if action == #selector(save(_:)) {
            return self.canSave
        }
        #endif

        return super.canPerformAction(action, withSender: sender)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}