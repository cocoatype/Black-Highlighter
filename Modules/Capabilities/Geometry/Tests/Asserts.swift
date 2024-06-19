//  Created by Geoff Pado on 6/19/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Geometry
import XCTest

func XCTAssertEqual(_ lhs: Shape, _ rhs: Shape, accuracy: Double) {
    for point in lhs.inverseTranslateRotateTransform {
        if !rhs.inverseTranslateRotateTransform.contains(where: { abs($0.x - point.x) <= accuracy && abs($0.y - point.y) <= accuracy }) {
            XCTFail("XCTAssertEqual failed: (\"\(String(describing: lhs))\") is not equal to (\"\(String(describing: rhs))\")")
        }
    }
}
