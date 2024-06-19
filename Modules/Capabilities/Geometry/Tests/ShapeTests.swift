//  Created by Geoff Pado on 10/19/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import XCTest

@testable import Geometry

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

    func testRectForIllDefinedShape() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 980.34822556083, y: 1495.0016611479539),
            bottomRight: CGPoint(x: 265.68262147954465, y: 1491.5924762993577),
            topLeft: CGPoint(x: 979.9312930237021, y: 1582.403006848055),
            topRight: CGPoint(x: 265.26568894241666, y: 1578.9938219994588)
        )

        dump(shape.unionDotShapeDotShapeDotUnionCrash)
    }
}
