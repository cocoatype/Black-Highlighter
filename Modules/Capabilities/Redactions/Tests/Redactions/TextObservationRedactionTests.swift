//  Created by Geoff Pado on 10/19/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Geometry
import Observations
import XCTest

@testable import Redactions

final class TextObservationRedactionTests: XCTestCase {
#if canImport(UIKit)
    func testInitIgnoresEmptyShapes() throws {
        let observation = MockTextObservation(bounds: Shape.emptySample)
        let redaction = Redaction(observation, color: .black)

        XCTAssertEqual(redaction.parts.count, 0)
    }

    func testInitIncludesNonEmptyShapes() throws {
        let observation = MockTextObservation(bounds: Shape.sample)
        let redaction = Redaction(observation, color: .black)

        XCTAssertEqual(redaction.parts.count, 1)
    }
#endif
}

private struct MockTextObservation: TextObservation {
    let bounds: Shape
}
