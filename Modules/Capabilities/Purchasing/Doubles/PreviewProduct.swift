//  Created by Geoff Pado on 5/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Purchasing
import StoreKit

public struct PreviewProduct: PurchaseProduct {
    public let id: String
    public let displayPrice = "$1.99"
    public let isPurchased = false

    public init() {
        id = UUID().uuidString
    }

    public func purchase() -> Bool {
        return false
    }
}
