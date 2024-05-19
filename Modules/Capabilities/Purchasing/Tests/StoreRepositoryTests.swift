//  Created by Geoff Pado on 9/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PurchasingDoubles
import XCTest

@testable import Purchasing

class StoreRepositoryTests: XCTestCase {
    func testFreeUnlockIfAppWasPurchasedEarly() async {
        let versionProvider = StubVersionProvider(originalPurchaseVersion: 100)
        let productProvider = StubProductProvider()
        let repository = StoreRepository(productProvider: productProvider, versionProvider: versionProvider)

        let purchaseState = await repository.noOnions
        XCTAssertEqual(purchaseState, .purchased)
    }

    func testFreeUnlockIfAppWasPurchasedLate() async {
        let versionProvider = StubVersionProvider(originalPurchaseVersion: 1000)
        let productProvider = StubProductProvider()
        let repository = StoreRepository(productProvider: productProvider, versionProvider: versionProvider)

        let purchaseState = await repository.noOnions
        XCTAssertNotEqual(purchaseState, .purchased)
    }
}
