//  Created by Geoff Pado on 12/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import LoggingDoubles
import ViewInspector
import XCTest

@testable import PurchaseMarketing

@available(iOS 16.0, *)
final class PurchaseMarketingTests: XCTestCase {
    func testWhenOnAppearThenAppearanceLogged() throws {
        let logger = SpyLogger()
        let view = PurchaseMarketingView(logger: logger)

        ViewHosting.host(view: view)
        defer { ViewHosting.expel() }

        let matchingEvents = logger.loggedEvents.count { event in
            event.name == .purchaseMarketingDisplayed
        }

        XCTAssertEqual(matchingEvents, 1)
    }
}
