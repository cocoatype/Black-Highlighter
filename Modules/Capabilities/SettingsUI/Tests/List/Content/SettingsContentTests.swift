//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing
import ViewInspector
import XCTest

@testable import SettingsUI

class SettingsContentTests: XCTestCase {
    func testSettingsContentContainsAppropriateSections() throws {
        let content = try SettingsContent(state: .loading).inspect().find(SettingsContent.self).find(ViewType.TupleView.self)
        XCTAssertEqual(content.count, 4)

        try XCTAssertNoThrow(content[0].find(SettingsContentPurchasedFeaturesSection.self))
        try XCTAssertNoThrow(content[1].find(SettingsContentInformationSection.self))
        try XCTAssertNoThrow(content[2].find(SettingsContentContactSection.self))
        try XCTAssertNoThrow(content[3].find(SettingsContentOtherAppsSection.self))
    }
}
