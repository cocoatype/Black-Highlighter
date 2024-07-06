//  Created by Geoff Pado on 5/13/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class PhotoEditingProtectionAlertController: UIAlertController {
    init(delegate: PhotoEditingProtectionAlertDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        view.tintColor = .controlTint

        addAction(shareAction)
        addAction(saveAction)
        addAction(deleteAction)
        addAction(cancelAction)
    }

    var barButtonItem: UIBarButtonItem? {
        get { return popoverPresentationController?.barButtonItem }
        set(newButtonItem) {
            popoverPresentationController?.barButtonItem = newButtonItem
        }
    }

    private lazy var shareAction = UIAlertAction(title: Strings.shareButtonTitle, style: .default) { [weak self] _ in
        self?.delegate?.presentShareDialogInPhotoEditingViewController()
    }
    private lazy var saveAction = UIAlertAction(title: Strings.saveButtonTitle, style: .default, handler: { [weak self] _ in
        self?.delegate?.dismissPhotoEditingViewControllerAfterSaving()
    })
    private lazy var deleteAction = UIAlertAction(title: Strings.deleteButtonTitle, style: .destructive, handler: { [weak self] _ in
        self?.delegate?.destructivelyDismissPhotoEditingViewController()
    })
    private lazy var cancelAction = UIAlertAction(title: Strings.cancelButtonTitle, style: .cancel, handler: nil)

    // MARK: Boilerplate

    override var preferredStyle: UIAlertController.Style {
        #if targetEnvironment(macCatalyst)
        return .alert
        #else
        return .actionSheet
        #endif
    }
    weak var delegate: PhotoEditingProtectionAlertDelegate?

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }

    private typealias Strings = CoreStrings.PhotoEditingProtectionAlertController
}

protocol PhotoEditingProtectionAlertDelegate: AnyObject {
    func dismissPhotoEditingViewControllerAfterSaving()
    func destructivelyDismissPhotoEditingViewController()
    func presentShareDialogInPhotoEditingViewController()
}
