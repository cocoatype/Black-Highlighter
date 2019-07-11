//  Created by Geoff Pado on 7/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingUserActivity: NSUserActivity {
    init(assetLocalIdentifier: String) {
        super.init(activityType: EditingUserActivity.defaultActivityType)
        title = EditingUserActivity.activityTitle
        userInfo = [EditingUserActivity.assetLocalIdentifierKey: assetLocalIdentifier]
    }

    // MARK: Boilerplate

    static let assetLocalIdentifierKey = "EditingUserActivity.assetLocalIdentifierKey"

    private static let defaultActivityType = "com.cocoatype.Highlighter.editing"
    private static let activityTitle = NSLocalizedString("EditingUserActivity.activityTitle", comment: "Title for the editing user activity")
}
