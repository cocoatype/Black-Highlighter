//  Created by Geoff Pado on 5/30/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

struct AppAppearanceWriter: AppearanceWriter {
    public func overwriteAppearance() {
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.tintColor = .white
        barButtonAppearance.setTitleTextAttributes(NavigationBar.buttonTitleTextAttributes, for: .normal)
        barButtonAppearance.setTitleTextAttributes(NavigationBar.buttonTitleTextAttributes, for: .highlighted)

        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .controlTint
    }
}
