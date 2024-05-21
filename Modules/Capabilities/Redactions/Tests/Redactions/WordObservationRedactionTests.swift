//  Created by Geoff Pado on 10/19/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Geometry
import Vision
import XCTest

@testable import Observations
@testable import Redactions

final class WordObservationRedactionTests: XCTestCase {
#if canImport(UIKit)
    func testInitIgnoresEmptyShapes() throws {
        let observation = try mockObservation(shape: Shape.emptySample)
        let redaction = Redaction([observation], color: .black)

        XCTAssertEqual(redaction.parts.count, 0)
    }

    func testInitIncludesNonEmptyShapes() throws {
        let observation = try mockObservation(shape: Shape.sample)
        let redaction = Redaction([observation], color: .black)

        XCTAssertEqual(redaction.parts.count, 1)
    }
#endif

    func mockObservation(shape: Shape) throws -> WordObservation {
        try XCTUnwrap(WordObservation(recognizedText: RecognizedText(recognizedText: MockVisionText("", shape: shape), uuid: UUID()), string: "", range: "".startIndex..<"".endIndex, imageSize: CGSize(width: 5, height: 5)))
    }
}

private struct MockVisionText: VisionText {
    init(_ string: String, shape: Shape) {
        self.string = string
        self.shape = shape
    }

    let string: String
    let shape: Shape

    func boundingBox(for range: Range<String.Index>) throws -> VNRectangleObservation? {
        VNRectangleObservation(requestRevision: 0, topLeft: shape.topLeft, bottomLeft: shape.bottomLeft, bottomRight: shape.bottomRight, topRight: shape.topRight)
    }
}
