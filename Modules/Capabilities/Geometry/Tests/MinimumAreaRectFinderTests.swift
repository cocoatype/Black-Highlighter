//  Created by Geoff Pado on 6/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import XCTest

@testable import Geometry

class MinimumAreaRectFinderTests: XCTestCase {
    func testMinimumAreaForRectWithNonIntegralOrigin() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 50.0000000000001, y: 150.0000000000001),
            bottomRight: CGPoint(x: 150.0000000000001, y: 150.0000000000001),
            topLeft: CGPoint(x: 50.0000000000001, y: 50.0000000000001),
            topRight: CGPoint(x: 150.0000000000001, y: 50.0000000000001)
        )

        let actualShape = MinimumAreaRectFinder.minimumAreaShape(for: [shape])

        XCTAssertEqual(actualShape, shape, accuracy: 0.01)
    }

    func testMinimumAreaForRectWithNonIntegralSize() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 50.0, y: 150.0000000000001),
            bottomRight: CGPoint(x: 150.0000000000001, y: 150.0000000000001),
            topLeft: CGPoint(x: 50.0, y: 50.0),
            topRight: CGPoint(x: 150.0000000000001, y: 50.0)
        )

        XCTAssertEqual(shape, MinimumAreaRectFinder.minimumAreaShape(for: [shape]), accuracy: 0.01)
    }

    func testMinimumAreaForRectWithInverseIntegralSize() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 50.0000000000001, y: 150.0),
            bottomRight: CGPoint(x: 150.0, y: 150.0),
            topLeft: CGPoint(x: 50.0000000000001, y: 50.0000000000001),
            topRight: CGPoint(x: 150.0, y: 50.0000000000001)
        )

        XCTAssertEqual(shape, MinimumAreaRectFinder.minimumAreaShape(for: [shape]), accuracy: 0.01)
    }

    func testMinimumAreaForIntegralShape() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 405.0, y: 1009.0),
            bottomRight: CGPoint(x: 432.0, y: 1009.0),
            topLeft: CGPoint(x: 405.0, y: 968.0),
            topRight: CGPoint(x: 432.0, y: 968.0)
        )

        XCTAssertEqual(shape, MinimumAreaRectFinder.minimumAreaShape(for: [shape]), accuracy: 0.01)
    }

    func testMinimumAreaForNonIntegralShape() {
        let shape = Shape(
            bottomLeft: CGPoint(x: 405.0, y: 1009.0000000000001),
            bottomRight: CGPoint(x: 432.0, y: 1009.0000000000001),
            topLeft: CGPoint(x: 405.0, y: 968.0000000000002),
            topRight: CGPoint(x: 432.0, y: 968.0000000000002)
        )

        XCTAssertEqual(shape, MinimumAreaRectFinder.minimumAreaShape(for: [shape]), accuracy: 0.01)
    }
}
