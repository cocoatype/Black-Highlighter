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

    func testNormalizedShape() {
        let originalShape = Shape(
            bottomLeft: CGPoint(x: 946.7962608595813, y: 1331.9914845573883),
            bottomRight: CGPoint(x: 269.4029737073748, y: 1349.2245818822003),
            topLeft: CGPoint(x: 948.5000076543305, y: 1398.961839335604),
            topRight: CGPoint(x: 271.10672050212395, y: 1416.194936660416)
        )

        let expectedShape = Shape(
            bottomLeft: originalShape.topRight,
            bottomRight: originalShape.topLeft,
            topLeft: originalShape.bottomRight,
            topRight: originalShape.bottomLeft
        )

        XCTAssertEqual(originalShape.ggImage, expectedShape, accuracy: 0.01)
    }
}
