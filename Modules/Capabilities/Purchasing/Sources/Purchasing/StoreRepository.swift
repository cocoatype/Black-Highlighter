//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit

class StoreRepository: PurchaseRepository {
    private(set) var withCheese: PurchaseState = .loading

    var noOnions: PurchaseState {
        get async {
            // go fetch the value
            let newValue = PurchaseState.purchased

            withCheese = newValue
            return newValue
        }
    }

    func start() {
        // subscribe to transaction updates
    }

    func purchase() async -> PurchaseState {
        // make purchase
        return .loading
    }

    func restore() async -> PurchaseState {
        // restore previous purchase
        return .loading
    }
}
