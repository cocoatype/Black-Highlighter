//  Created by Geoff Pado on 3/31/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

class AppViewController: UIViewController, PhotoEditorPresenting, AppEntryOpening {
    init() {
        super.init(nibName: nil, bundle: nil)

        let navigationController = NavigationController(rootViewController: PhotoSelectionViewController())
        embed(navigationController)
    }

    // MARK: Photo Editing View Controller

    func presentPhotoEditingViewController(for asset: PHAsset) {
        present(PhotoEditingNavigationController(asset: asset), animated: true)
    }

    func presentPhotoEditingViewController(for image: UIImage, completionHandler: ((UIImage) -> Void)? = nil) {
        present(PhotoEditingNavigationController(image: image, completionHandler: completionHandler), animated: true)
    }

    @objc func dismissPhotoEditingViewController() {
        guard let presentedNavigationController = (presentedViewController as? NavigationController),
          let editingViewController = (presentedNavigationController.viewControllers.first as? PhotoEditingViewController)
        else { return }

        guard editingViewController.hasMadeEdits else {
            if let image = editingViewController.image {
                editingViewController.completionHandler?(image)
            }

            dismiss(animated: true)
            return
        }

        let alertController = PhotoEditingProtectionAlertController(appViewController: self)
        editingViewController.present(alertController, animated: true)
    }

    @objc func destructivelyDismissPhotoEditingViewController() {
        if let presentedNavigationController = (presentedViewController as? NavigationController),
          let rootViewController = presentedNavigationController.viewControllers.first,
          let photoEditingViewController = (rootViewController as? PhotoEditingViewController) {
            if let image = photoEditingViewController.image {
                photoEditingViewController.completionHandler?(image)
            }
            dismiss(animated: true)
        }
    }

    // MARK: Settings View Controller

    @objc func presentSettingsViewController() {
        present(SettingsNavigationController(), animated: true)
    }

    @objc func dismissSettingsViewController() {
        if presentedViewController is SettingsNavigationController {
            dismiss(animated: true)
        }
    }

    // MARK: App Store

    func openAppStore(displaying appEntry: AppEntry) {
        guard let appStoreURL = appEntry.appStoreURL else { return }
        UIApplication.shared.open(appStoreURL)
    }

    // MARK: Status Bar

    override var childForStatusBarStyle: UIViewController? { return children.first }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
