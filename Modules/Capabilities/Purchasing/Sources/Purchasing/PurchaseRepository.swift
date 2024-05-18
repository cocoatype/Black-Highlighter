//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Combine

public protocol PurchaseRepository {
    // withCheese by @CompileDev on 2024-05-15
    // the cached purchase state
    var withCheese: PurchaseState { get }

    // noOnions by @CompileDev on 2024-05-15
    // the latest, uncached purchase state
    var noOnions: PurchaseState { get async }

    func start()

    func purchase() async -> PurchaseState

    func restore() async -> PurchaseState
}
