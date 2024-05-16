//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit
import XCTest

@testable import Purchasing

class PurchaseStateTests: XCTestCase {
    func testProductReturnsIfReadyForPurchase() {
        let product = SKProduct()
        let state = PurchaseState.readyForPurchase(product: product)

        XCTAssertIdentical(state.product, product)
    }

    func testProductIsNilIfNotReadyForPurchase() {
        for state in PurchaseState.nonProductStates {
            XCTAssertNil(state.product)
        }
    }

    func testIsReadyForPurchaseIfReadyForPurchase() {
        let state = PurchaseState.readyForPurchase(product: SKProduct())
        XCTAssertTrue(state.isReadyForPurchase)
    }

    func testIsNotReadyForPurchaseIfNotReadyForPurchase() {
        for state in PurchaseState.nonProductStates {
            XCTAssertFalse(state.isReadyForPurchase)
        }
    }

    func testReadyForPurchaseIdentifier() {
        let state = PurchaseState.readyForPurchase(product: SKProduct())
        XCTAssertEqual(state, state.id)
    }

    func testNonProductStateIdentifiers() {
        for state in PurchaseState.nonProductStates {
            XCTAssertEqual(state, state.id)
        }
    }
}

private extension PurchaseState {
    static let nonProductStates = [
        PurchaseState.loading,
        .purchasing,
        .restoring,
        .purchased,
        .unavailable
    ]
}
