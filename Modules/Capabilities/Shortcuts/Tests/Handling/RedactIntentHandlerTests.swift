//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PurchasingDoubles
import XCTest

@testable import Shortcuts

class RedactIntentHandlerTests: XCTestCase {
    func testHandleReturnsUnpurchasedIfNotPurchased() async throws {
        guard #available(iOS 16, *) else { throw XCTSkip() }

        let repository = SpyRepository(withCheese: .unavailable)
        let intent = RedactDetectionsIntent()
        let handler = RedactIntentHandler(purchaseRepository: repository)

        do {
            _ = try await handler.handle(💩: intent) { _ in
                return { file, _, _ in
                    RedactedFile(sourceImage: file, redactedImage: file, redactions: [])
                }
            }
            XCTFail("Expected unpurchased error")
        } catch ShortcutsRedactorError.unpurchased {}
    }
}
