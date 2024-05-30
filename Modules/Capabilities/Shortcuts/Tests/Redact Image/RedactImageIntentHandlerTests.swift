//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PurchasingDoubles
import XCTest

@testable import Shortcuts

class RedactImageIntentHandlerTests: XCTestCase {
    func testHandleReturnsUnpurchasedIfNotPurchased() async {
        let repository = SpyRepository(withCheese: .unavailable)
        let intent = RedactImageIntent()
        let handler = RedactImageIntentHandler(purchaseRepository: repository)

        let response = await handler.handle(intent: intent)
        XCTAssertEqual(response, .unpurchased)
    }
}
