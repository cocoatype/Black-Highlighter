//  Created by Geoff Pado on 5/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit

public protocol PurchaseProduct: Hashable, Identifiable {
    var id: String { get }
    var displayPrice: String { get }
    var currentEntitlement: VerificationResult<Transaction>? { get async }
    func purchase(options: Set<Product.PurchaseOption>) async throws -> Product.PurchaseResult
}

extension Product: PurchaseProduct {}
