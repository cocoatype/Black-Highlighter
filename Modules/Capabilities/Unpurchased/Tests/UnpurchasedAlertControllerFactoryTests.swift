//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import XCTest

@testable import Unpurchased

class UnpurchasedAlertControllerFactoryTests: XCTestCase {
    func testAlertControllerHasCorrectTint() {
        let feature = UnpurchasedFeature(message: "", learnMoreAction: nil, hideFeatureKey: nil)
        let factory = UnpurchasedAlertControllerFactory()
        let alert = factory.alertController(for: feature)

        XCTAssertEqual(alert.view.tintColor, .controlTint)
    }

    func testAlertControllerSetsMessage() {
        let feature = UnpurchasedFeature(message: "Hello, world!", learnMoreAction: nil, hideFeatureKey: nil)
        let factory = UnpurchasedAlertControllerFactory()
        let alert = factory.alertController(for: feature)

        XCTAssertEqual(alert.message, feature.message)
    }

    func testAlertControllerAlwaysHasOneAction() {
        let feature = UnpurchasedFeature(message: "", learnMoreAction: nil, hideFeatureKey: nil)
        let factory = UnpurchasedAlertControllerFactory()
        let alert = factory.alertController(for: feature)

        XCTAssertEqual(alert.actions.count, 1)
    }

    func testAlertControllerAddsActionForLearnMore() {
        let feature = UnpurchasedFeature(message: "", learnMoreAction: {}, hideFeatureKey: nil)
        let factory = UnpurchasedAlertControllerFactory()
        let alert = factory.alertController(for: feature)

        XCTAssertEqual(alert.actions.count, 2)
    }

    func testAlertControllerAddsActionForHideFeature() {
        let feature = UnpurchasedFeature(message: "", learnMoreAction: nil, hideFeatureKey: .hideAutoRedactions)
        let factory = UnpurchasedAlertControllerFactory()
        let alert = factory.alertController(for: feature)

        XCTAssertEqual(alert.actions.count, 2)
    }
}
