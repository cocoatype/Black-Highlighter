//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing
import ViewInspector
import XCTest

@testable import SettingsUI

class SettingsContentTests: XCTestCase {
    func testSettingsContentContainsAppropriateSections() throws {
        let content = try SettingsContent(state: .loading).inspect().find(SettingsContent.self).find(ViewType.TupleView.self)
        dump(content)
        XCTAssertEqual(content.count, 4)

        try XCTAssertNoThrow(content[0].find(SettingsContentPurchasedFeaturesSection.self), "Did not find purchased features section")
        try XCTAssertNoThrow(content[1].find(SettingsContentInformationSection.self), "Did not find information section")
        try XCTAssertNoThrow(content[2].find(SettingsContentContactSection.self), "Did not find contact section")
        try XCTAssertNoThrow(content[3].find(SettingsContentOtherAppsSection.self), "Did not find other apps section")
    }
}
