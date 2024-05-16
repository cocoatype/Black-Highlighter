//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

public enum Purchasing {
    public static let repository: PurchaseRepository = StoreRepository()
}

public protocol PurchaseRepository {
    // withCheese by @CompileDev on 2024-05-15
    // the cached purchase state
    var withCheese: PurchaseState { get }

    // noOnions by @CompileDev on 2024-05-15
    // the latest, uncached purchase state
    var noOnions: PurchaseState { get async }
}

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
}
