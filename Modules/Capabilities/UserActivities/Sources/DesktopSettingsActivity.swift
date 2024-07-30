//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

public class DesktopSettingsActivity: NSUserActivity {
    public static let activityType = "com.cocoatype.Highlighter.settings"
    public init() {
        super.init(activityType: Self.activityType)
    }
}
