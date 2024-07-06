//  Created by Geoff Pado on 7/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if targetEnvironment(macCatalyst)
import UIKit

class DesktopSaveAlertController: UIAlertController {
    convenience init(error: DesktopSaveError) {
        self.init(title: error.alertTitle, message: error.alertMessage, preferredStyle: .alert)
        addAction(UIAlertAction(title: CoreStrings.DesktopSaveAlertController.dismissButtonTitle, style: .default, handler: nil))
    }
}
#endif
