//  Created by Geoff Pado on 6/19/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Geometry
import XCTest

func XCTAssertEqual(_ lhs: Shape, _ rhs: Shape, accuracy: Double) {
    let lhsPoints = [lhs.bottomLeft, lhs.bottomRight, lhs.topLeft, lhs.topRight]
    let rhsPoints = [rhs.bottomLeft, rhs.bottomRight, rhs.topLeft, rhs.topRight]

    for point in lhsPoints {
        if !rhsPoints.contains(where: { abs($0.x - point.x) <= accuracy && abs($0.y - point.y) <= accuracy }) {
            XCTFail("XCTAssertEqual failed: (\"\(String(describing: lhs))\") is not equal to (\"\(String(describing: rhs))\")")
        }
    }
}
