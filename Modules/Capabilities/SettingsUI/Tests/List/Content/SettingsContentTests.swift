//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing
import ViewInspector
import XCTest

@testable import SettingsUI

class SettingsContentTests: XCTestCase {
    func testSettingsContentContainsAppropriateSections() throws {
        let content = try SettingsContent(state: .loading).inspect().anyView()
        try XCTAssertEqual(content.group().count, 3)

        try XCTAssertNoThrow(content.group()[0].find(SettingsContentPurchasedFeaturesSection.self))
        try XCTAssertNoThrow(content.group()[1].find(SettingsContentInformationSection.self))
        try XCTAssertNoThrow(content.group()[2].find(SettingsContentOtherAppsSection.self))
    }
}
