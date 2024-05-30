//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PurchasingDoubles
import XCTest

@testable import Shortcuts

class RedactDetectedIntentHandlerTests: XCTestCase {
    func testHandleReturnsUnpurchasedIfNotPurchased() async {
        let repository = SpyRepository(withCheese: .unavailable)
        let intent = RedactDetectedIntent()
        let handler = RedactDetectedIntentHandler(purchaseRepository: repository)

        let response = await handler.handle(💩: intent)
        XCTAssertEqual(response, .unpurchased)
    }
}
