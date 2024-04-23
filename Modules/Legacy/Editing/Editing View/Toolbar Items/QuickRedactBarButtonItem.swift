//  Created by Geoff Pado on 4/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class QuickRedactBarButtonItem: UIBarButtonItem {
    convenience init(target: AnyObject?) {
        self.init(image: UIImage(systemName: "bolt"), style: .plain, target: target, action: #selector(ActionsBuilderActions.showQuickRedactMenu(_:)))
        accessibilityLabel = NSLocalizedString("QuickRedactBarButtonItem.accessibilityLabel", comment: "Accessibility label for the quick redact toolbar item")
    }
}
