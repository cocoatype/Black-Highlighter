//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import LoggingDoubles
import PurchasingDoubles
import TestHelpers
import XCTest

@testable import Core

class AppDelegateTests: XCTestCase {
    func testWillFinishLaunchingCallsStartOnPurchaseRepository() {
        let repository = SpyRepository(startExpectation: expectation(description: "start called"))
        let logger = SpyLogger()
        let delegate = AppDelegate(purchaseRepository: repository, logger: logger)

        _ = delegate.application(UIApplication.shared, willFinishLaunchingWithOptions: nil)

        waitForExpectations(timeout: 1)
    }
}
