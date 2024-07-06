//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AutoRedactionsUI
import PurchaseMarketing
import ViewInspector
import XCTest

@testable import SettingsUI

class SettingsContentPurchasedFeaturesSectionTests: XCTestCase {
    func testContainsPurchaseNavigationLinkIfNotPurchased() throws {
        let section = try SettingsContentPurchasedFeaturesSection(state: .loading).inspect().find(SettingsContentPurchasedFeaturesSection.self)

        XCTAssertNoThrow(try section.find(PurchaseNavigationLink<PurchaseMarketingView>.self))
    }

    func testDoesNotContainSettingsNavigationLinkIfNotPurchased() throws {
        let section = try SettingsContentPurchasedFeaturesSection(state: .loading).inspect().find(SettingsContentPurchasedFeaturesSection.self)

        XCTAssertThrowsError(try section.find(SettingsNavigationLink<AutoRedactionsEditView>.self))
    }

    func testDoesNotContainPurchaseNavigationLinkIfPurchased() throws {
        let section = try SettingsContentPurchasedFeaturesSection(state: .purchased).inspect().find(SettingsContentPurchasedFeaturesSection.self)

        XCTAssertThrowsError(try section.find(PurchaseNavigationLink<PurchaseMarketingView>.self))
    }

    func testContainsSettingsNavigationLinkIfPurchased() throws {
        let section = try SettingsContentPurchasedFeaturesSection(state: .purchased).inspect().find(SettingsContentPurchasedFeaturesSection.self)

        XCTAssertNoThrow(try section.find(SettingsNavigationLink<AutoRedactionsEditView>.self))
    }
}
