//  Created by Geoff Pado on 10/19/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import XCTest

@testable import Observations

final class ShapeTests: XCTestCase {
    func testIsNotEmptyReturnsFalseForEmptyShape() {
        let emptyShape = Shape(
            bottomLeft: CGPoint(x: 5, y: 5),
            bottomRight: CGPoint(x: 5, y: 5),
            topLeft: CGPoint(x: 5, y: 5),
            topRight: CGPoint(x: 5, y: 5)
        )

        XCTAssertFalse(emptyShape.isNotEmpty)
    }

    func testIsNotEmptyReturnsTrueForNonEmptyShape() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 0, y: 5),
            bottomRight: CGPoint(x: 5, y: 5),
            topLeft: CGPoint(x: 0, y: 0),
            topRight: CGPoint(x: 5, y: 0)
        )

        XCTAssertTrue(shape.isNotEmpty)
    }
}
