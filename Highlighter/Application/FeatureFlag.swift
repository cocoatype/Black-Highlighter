//  Created by Geoff Pado on 12/6/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Foundation

public enum FeatureFlag {
    public static var seekAndDestroy: Bool {
        UserDefaults.standard.bool(forKey: "FeatureFlag.seekAndDestroy")
    }
}
