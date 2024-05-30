//  Created by Geoff Pado on 5/30/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Combine

struct LegacyRepository: PurchaseRepository {
    let withCheese = PurchaseState.purchased
    let noOnions = PurchaseState.purchased

    let purchaseStates: any Publisher<PurchaseState, Never> = Just(.purchased)

    func start() {}

    func purchase() async -> PurchaseState {
        return .purchased
    }

    func restore() async -> PurchaseState {
        return .purchased
    }
}
