//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit

struct AppPurchaseVersionProvider: PurchaseVersionProvider {
    var originalPurchaseVersion: Int {
        get async throws {
            // not worth handling iOS 15, they get the app for free
            guard #available(iOS 16, *) else { return 0 }

            let appTransaction = try await AppTransaction.shared.payloadValue
            let versionString = appTransaction.originalAppVersion
            guard let version = Int(versionString) else {
                throw PurchaseError.unparseableAppVersion(version: versionString)
            }

            return version
        }
    }
}
