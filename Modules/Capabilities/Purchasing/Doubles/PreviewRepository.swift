//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing

public struct PreviewRepository: PurchaseRepository {
    public var withCheese: PurchaseState
    public var noOnions: PurchaseState { withCheese }
    public init(purchaseState: PurchaseState) {
        withCheese = purchaseState
    }

    public func start() {}
    public func purchase() async -> PurchaseState { withCheese }
    public func restore() async -> PurchaseState { withCheese }
}
