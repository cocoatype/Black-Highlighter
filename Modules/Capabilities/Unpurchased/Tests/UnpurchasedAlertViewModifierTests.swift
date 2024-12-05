//  Created by Geoff Pado on 12/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import LoggingDoubles
import SwiftUI
import ViewInspector
import XCTest

@testable import Unpurchased

class UnpurchasedAlertViewModifierTests: XCTestCase {
    @MainActor func testWhenIsPresentedTrueThenEventLogged() throws {
        let logger = SpyLogger()
        let modifier = UnpurchasedAlertViewModifier(for: .autoRedactions(), isPresented: .constant(false), logger: logger)

        try modifier.inspect().implicitAnyView().viewModifierContent().callOnChange(newValue: true)

        XCTAssert(logger.loggedEvents.contains(where: { $0.name == "UnpurchasedAlertViewModifier.isPresented" }))
    }

    @MainActor func testWhenIsPresentedFalseThenEventNotLogged() throws {
        let logger = SpyLogger()
        let modifier = UnpurchasedAlertViewModifier(for: .autoRedactions(), isPresented: .constant(false), logger: logger)

        try modifier.inspect().implicitAnyView().viewModifierContent().callOnChange(newValue: false)

        XCTAssertFalse(logger.loggedEvents.contains(where: { $0.name == "UnpurchasedAlertViewModifier.isPresented" }))
    }
}
