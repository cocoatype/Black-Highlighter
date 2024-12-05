//  Created by Geoff Pado on 12/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import LoggingDoubles
import XCTest

@testable import Unpurchased

class UnpurchasedAlertControllerTests: XCTestCase {
    func testWhenViewDidAppearThenEventLogged() {
        let logger = SpyLogger()
        let alertController = UnpurchasedAlertController()
        alertController.logger = logger

        alertController.viewDidAppear(false)

        XCTAssert(logger.loggedEvents.contains(where: { $0.name == "UnpurchasedAlertController.viewDidAppear" }))
    }
}
