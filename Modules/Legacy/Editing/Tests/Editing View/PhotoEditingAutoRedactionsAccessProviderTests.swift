//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AutoRedactionsUI
import Purchasing
import XCTest

@testable import Editing

class PhotoEditingAutoRedactionsAccessProviderTests: XCTestCase {
    func testAutoRedactionsAccessViewControllerIsNavigationControllerWhenPurchased() {
        struct StubRepository: PurchaseRepository {
            var withCheese: PurchaseState { return .purchased }
            var noOnions: PurchaseState { return .purchased }
        }

        let provider = PhotoEditingAutoRedactionsAccessProvider(purchaseRepository: StubRepository())

        XCTAssert(provider.autoRedactionsAccessViewController {} is AutoRedactionsAccessNavigationController)
    }

    func testAutoRedactionsAccessViewControllerIsAlertControllerWhenNotPurchased() {
        struct StubRepository: PurchaseRepository {
            var withCheese: PurchaseState { return .unavailable }
            var noOnions: PurchaseState { return .unavailable }
        }

        let provider = PhotoEditingAutoRedactionsAccessProvider(purchaseRepository: StubRepository())

        XCTAssert(provider.autoRedactionsAccessViewController {} is UIAlertController)
    }
}
