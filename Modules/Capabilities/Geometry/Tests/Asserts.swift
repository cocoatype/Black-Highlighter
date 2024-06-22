//  Created by Geoff Pado on 6/19/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Geometry
import XCTest

func XCTAssertEqual(_ lhs: Shape, _ rhs: Shape, accuracy: Double, file: StaticString = #filePath, line: UInt = #line) {
    guard lhs.inverseTranslateRotateTransform.contains(where: { point in
        let hasMatchingPoint = rhs.inverseTranslateRotateTransform.contains(where: { abs($0.x - point.x) <= accuracy && abs($0.y - point.y) <= accuracy })
        return hasMatchingPoint == false
    }) else { return }

    XCTFail("XCTAssertEqual failed: (\"\(String(describing: lhs))\") is not equal to (\"\(String(describing: rhs))\")", file: file, line: line)
}
