//  Created by Geoff Pado on 12/6/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Foundation

public enum FeatureFlag {
    public static var autoRedactInEdit: Bool {
        UserDefaults.standard.bool(forKey: "FeatureFlag.autoRedactInEdit")
    }

    public static var shouldShowDebugOverlay: Bool {
        ProcessInfo.processInfo.environment["SHOW_DEBUG_OVERLAY"] != nil
    }
}
