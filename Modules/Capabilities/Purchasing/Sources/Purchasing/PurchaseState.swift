//  Created by Geoff Pado on 8/11/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import StoreKit

public enum PurchaseState: Identifiable, Hashable {
    case loading
    case readyForPurchase(product: SKProduct)
    case purchasing
    case restoring
    case purchased
    case unavailable

    public var product: SKProduct? {
        switch self {
        case .readyForPurchase(let product): return product
        default: return nil
        }
    }

    public var id: Self { self }
}
