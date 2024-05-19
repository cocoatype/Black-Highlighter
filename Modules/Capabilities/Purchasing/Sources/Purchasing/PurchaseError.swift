//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

enum PurchaseError: Error {
    case paymentsNotAvailable
    case productNotFound(identifier: String)
    case unparseableAppVersion(version: String)
    case unknown
}
