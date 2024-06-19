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

    func testUnionOfRotatedShapes() {
        let firstShape = Shape(
            bottomLeft: CGPoint(x: 126.74248082927248, y: 1112.9254289499572),
            bottomRight: CGPoint(x: 342.6968497848278, y: 948.305784288113),
            topLeft: CGPoint(x: 53.420223253429214, y: 1016.2733621454367),
            topRight: CGPoint(x: 269.7560323061029, y: 852.1565330586908)
        )

        let secondShape = Shape(
            bottomLeft: CGPoint(x: 354.71550618850557, y: 939.1881821032728),
            bottomRight: CGPoint(x: 805.0458405740253, y: 598.3504663849724),
            topLeft: CGPoint(x: 281.7746887097807, y: 843.0389308738502),
            topRight: CGPoint(x: 731.723582998182, y: 501.6983995804519)
        )

        let expectedShape = Shape(
            bottomLeft: CGPoint(x: 126.74248082927248, y: 1112.9254289499572),
            bottomRight: CGPoint(x: 805.0458405740253, y: 598.3504663849724),
            topLeft: CGPoint(x: 53.420223253429214, y: 1016.2733621454367),
            topRight: CGPoint(x: 731.723582998182, y: 501.6983995804519)
        )

        let unionShape = firstShape.union(secondShape)
        XCTAssert(unionShape.path.isEqual(to: expectedShape.path, accuracy: 0.01))
    }

    func testUnionOfFiveShapes() {
        let shapes = [
              Shape(
                bottomLeft: CGPoint(x: 405.0, y: 1009.0000000000001),
                bottomRight: CGPoint(x: 432.0, y: 1009.0000000000001),
                topLeft: CGPoint(x: 405.0, y: 968.0000000000002),
                topRight: CGPoint(x: 432.0, y: 968.0000000000002)
              ),
              Shape(
                bottomLeft: CGPoint(x: 435.0, y: 1008.0),
                bottomRight: CGPoint(x: 500.0, y: 1008.0),
                topLeft: CGPoint(x: 435.0, y: 968.0000000000002),
                topRight: CGPoint(x: 500.0, y: 968.0000000000002)
              ),
              Shape(
                bottomLeft: CGPoint(x: 503.0, y: 1008.0),
                bottomRight: CGPoint(x: 522.0, y: 1008.0),
                topLeft: CGPoint(x: 503.0, y: 951.0),
                topRight: CGPoint(x: 522.0, y: 951.0)
              ),
              Shape(
                bottomLeft: CGPoint(x: 525.0, y: 1021.0000000000001),
                bottomRight: CGPoint(x: 566.0, y: 1021.0000000000001),
                topLeft: CGPoint(x: 525.0, y: 968.0000000000002),
                topRight: CGPoint(x: 566.0, y: 968.0000000000002)
              ),
              Shape(
                bottomLeft: CGPoint(x: 568.0, y: 1009.0000000000001),
                bottomRight: CGPoint(x: 603.0, y: 1009.0000000000001),
                topLeft: CGPoint(x: 568.0, y: 968.0000000000002),
                topRight: CGPoint(x: 603.0, y: 968.0000000000002)
              ),
        ]

        let expectedShape = Shape(
            bottomLeft: CGPoint(x: 405.0, y: 1021.0),
            bottomRight: CGPoint(x: 603.0, y: 1021.0),
            topLeft: CGPoint(x: 405.0, y: 951.0),
            topRight: CGPoint(x: 603.0, y: 951.0)
        )

        var remainingShapes = shapes
        let firstShape = remainingShapes.removeFirst()

        let unionShape = remainingShapes.reduce(firstShape) { combinedShape, newShape in
            combinedShape.union(newShape)
        }

        XCTAssertEqual(unionShape, expectedShape, accuracy: 0.01)
    }
}
