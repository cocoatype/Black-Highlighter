//  Created by Geoff Pado on 2/25/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Editing
import Redactions
import Scenes
import UIKit

#if targetEnvironment(macCatalyst)
class DesktopAppWindow: UIWindow {
    init(windowScene: UIWindowScene, dependencies: SceneDependencies) {
        desktopViewController = DesktopViewController(dependencies: dependencies)
        super.init(windowScene: windowScene)

        rootViewController = desktopViewController
    }

    var stateRestorationActivity: NSUserActivity? {
        desktopViewController.stateRestorationActivity
    }

    // MARK: Boilerplate

    let desktopViewController: DesktopViewController

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}

class DesktopDocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    init() {
        super.init(forOpening: [.image])

        allowsDocumentCreation = false
        delegate = self
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
#endif
