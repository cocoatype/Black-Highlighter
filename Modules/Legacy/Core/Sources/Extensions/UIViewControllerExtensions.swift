//  Created by Geoff Pado on 4/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PhotosUI
import UIKit

extension UIViewController {
    var shouldOverrideInterfaceStyle: Bool {
        return self is UIImagePickerController || self is PHPickerViewController
    }

    var topPresentedViewController: UIViewController {
        guard let presentedViewController else { return self }
        return presentedViewController.topPresentedViewController
    }
}
