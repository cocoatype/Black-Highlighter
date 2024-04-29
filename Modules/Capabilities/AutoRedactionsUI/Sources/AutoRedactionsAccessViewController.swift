//  Created by Geoff Pado on 4/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

public class AutoRedactionsAccessNavigationController: UINavigationController {
    public init() {
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
        setViewControllers([AutoRedactionsAccessViewController()], animated: false)

        if #available(iOS 15.0, *) {
            sheetPresentationController?.detents = [.medium()]
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

@objc public protocol AutoRedactionsAccessActions {
    func hideAutoRedactAccess(_ sender: Any)
}

public class AutoRedactionsAccessViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(AutoRedactionsAccessActions.hideAutoRedactAccess(_:)))

        embed(AutoRedactionsListViewController())
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
