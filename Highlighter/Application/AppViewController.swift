//  Created by Geoff Pado on 3/31/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

class AppViewController: UIViewController, PhotoEditorPresenting {
    init() {
        super.init(nibName: nil, bundle: nil)

        let navigationController = NavigationController(rootViewController: PhotoSelectionViewController())
        embed(navigationController)
    }

    // MARK: Photo Editing View Controller

    func presentPhotoEditingViewController(for asset: PHAsset) {
        let navigationController = NavigationController(rootViewController: PhotoEditingViewController(asset: asset))
        present(navigationController, animated: true)
    }

    @objc func dismissPhotoEditingViewController() {
        if let presentedNavigationController = (presentedViewController as? NavigationController),
          let rootViewController = presentedNavigationController.viewControllers.first,
          rootViewController is PhotoEditingViewController {
            dismiss(animated: true)
        }
    }

    // MARK: Settings View Controller

    @objc func presentSettingsViewController() {
        let navigationController = NavigationController(rootViewController: SettingsViewController())
        present(navigationController, animated: true)
    }

    @objc func dismissSettingsViewController() {
        if let presentedNavigationController = (presentedViewController as? NavigationController),
          let rootViewController = presentedNavigationController.viewControllers.first,
          rootViewController is SettingsViewController {
            dismiss(animated: true)
        }
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
