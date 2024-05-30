//  Created by Geoff Pado on 5/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Shortcuts

@available(iOS 17.0, *)
struct AppShortcutsPackage: AppIntentsPackage {
    static var includedPackages: [any AppIntentsPackage.Type] {
        [ShortcutsPackage.self]
    }
}
