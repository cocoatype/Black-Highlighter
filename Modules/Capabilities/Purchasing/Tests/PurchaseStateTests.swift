//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit
import XCTest

@testable import Purchasing

class PurchaseStateTests: XCTestCase {
    func testProductReturnsIfReadyForPurchase() {
        let product = TestProduct()
        let state = PurchaseState.readyForPurchase(product: product)

        XCTAssertEqual(state.product as? TestProduct, product)
    }

    func testProductIsNilIfNotReadyForPurchase() {
        for state in PurchaseState.nonProductStates {
            XCTAssertNil(state.product)
        }
    }

    func testIsReadyForPurchaseIfReadyForPurchase() {
        let state = PurchaseState.readyForPurchase(product: TestProduct())
        XCTAssertTrue(state.isReadyForPurchase)
    }

    func testIsNotReadyForPurchaseIfNotReadyForPurchase() {
        for state in PurchaseState.nonProductStates {
            XCTAssertFalse(state.isReadyForPurchase)
        }
    }

    func testReadyForPurchaseIdentifier() {
        let state = PurchaseState.readyForPurchase(product: TestProduct())
        XCTAssertEqual(state, state.id)
    }

    func testNonProductStateIdentifiers() {
        for state in PurchaseState.nonProductStates {
            XCTAssertEqual(state, state.id)
        }
    }

    private struct TestProduct: PurchaseProduct {
        let id = "test"
        let displayPrice = ""
        let currentEntitlement: VerificationResult<Transaction>? = nil

        func purchase(options: Set<Product.PurchaseOption>) async throws -> Product.PurchaseResult {
            .userCancelled
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
