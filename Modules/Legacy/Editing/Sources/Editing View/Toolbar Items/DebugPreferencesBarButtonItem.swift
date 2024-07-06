//  Created by Geoff Pado on 6/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class DebugPreferencesBarButtonItem: UIBarButtonItem {
    convenience init(target: AnyObject?) {
        self.init(image: UIImage(systemName: "ladybug"), style: .plain, target: target, action: #selector(ActionsBuilderActions.showDebugPreferences(_:)))
        accessibilityLabel = EditingStrings.DebugPreferencesBarButtonItem.accessibilityLabel
    }
}
