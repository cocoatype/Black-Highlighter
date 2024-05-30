//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import StoreKit

@available(iOS 16.0, *)
struct AppPurchaseVersionProvider: PurchaseVersionProvider {
    var originalPurchaseVersion: Int {
        get async {
            do {
                #if DEBUG
                return .max
                #else
                let appTransaction = try await AppTransaction.shared.payloadValue
                let versionString = appTransaction.originalAppVersion
                guard let version = Int(versionString) else {
                    throw PurchaseError.unparseableAppVersion(version: versionString)
                }

                return version
                #endif
            } catch {
                ErrorHandler().log(error)
                return .max
            }
        }
    }
}
