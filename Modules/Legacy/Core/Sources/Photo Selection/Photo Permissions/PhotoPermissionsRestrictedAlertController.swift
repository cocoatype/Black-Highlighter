//  Created by Geoff Pado on 5/13/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class PhotoPermissionsRestrictedAlertFactory: NSObject {
    static func alert() -> PhotoPermissionsRestrictedAlertController {
        let alertController = PhotoPermissionsRestrictedAlertController(title: Strings.alertTitle, message: Strings.alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = .controlTint

        alertController.addAction(dismissAction)

        return alertController
    }

    private static let dismissAction = UIAlertAction(title: Strings.dismissButtonTitle, style: .cancel, handler: nil)

    private typealias Strings = CoreStrings.PhotoPermissionsRestrictedAlertFactory
}

class PhotoPermissionsRestrictedAlertController: UIAlertController {}
