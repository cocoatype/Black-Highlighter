//  Created by Geoff Pado on 4/17/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

#if targetEnvironment(macCatalyst)
class HelpMenuAboutAction: UIAction {
    convenience init(void: Void = ()) {
        self.init(title: Self.menuItemTitle) { _ in
            UIApplication.shared.open(AboutViewController.url, options: [:], completionHandler: nil)
        }
    }

    // MARK: Boilerplate

    private static let menuItemTitle = NSLocalizedString("SettingsContentProvider.Item.about", comment: "About menu item title")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
#endif