//  Created by Geoff Pado on 4/17/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SettingsUI
import UIKit

#if targetEnvironment(macCatalyst)
class HelpMenuAcknowledgementsAction: UIAction {
    convenience init(void: Void = ()) {
        self.init(title: Self.menuItemTitle) { _ in
            UIApplication.shared.open(URL(websitePath: "acknowledgements"), options: [:], completionHandler: nil)
        }
    }

    // MARK: Boilerplate

    private static let menuItemTitle = SettingsUIStrings.SettingsContentInformationSection.acknowledgementsTitle

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
#endif
