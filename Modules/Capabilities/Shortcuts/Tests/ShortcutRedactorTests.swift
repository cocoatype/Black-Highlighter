//  Created by Geoff Pado on 7/29/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import AppIntents
import Detections
import Observations
import Redactions
import UniformTypeIdentifiers
import Vision
import XCTest

@testable import Shortcuts

class ShortcutRedactorTests: XCTestCase {
    func testRedactWordsUsesInputWordList() throws {
        guard #available(iOS 16, *) else { throw XCTSkip() }

        let exportExpectation = expectation(description: "export called")
        let redactor = ShortcutRedactor(detector: StubTextDetector(), exporter: StubRedactExporter(exportExpectation: exportExpectation, expectedRedactionCount: 1))
        let imageData = try XCTUnwrap(UIImage(systemName: "bolt")?.pngData())
        let file = IntentFile(data: imageData, filename: "image.png", type: .png)

        Task {
            try await redactor.redact(file, words: ["hello"])
        }

        waitForExpectations(timeout: 1)
    }

    func testRedactionThrowsError() throws {
        guard #available(iOS 16, *) else { throw XCTSkip() }

        let exportExpectation = expectation(description: "export called")
        exportExpectation.isInverted = true
        let redactor = ShortcutRedactor(detector: StubTextDetector(), exporter: StubRedactExporter(exportExpectation: exportExpectation, expectedRedactionCount: 1))
        let imageData = Data()
        let file = IntentFile(data: imageData, filename: "image.png", type: .png)

        Task {
            do {
                _ = try await redactor.redact(file, words: ["hello"])
                XCTFail("did not catch expected error")
            } catch ShortcutsRedactorError.noImage {}
        }

        waitForExpectations(timeout: 0.01)
    }
}

private struct MockVisionText: VisionText {
    init(_ string: String) {
        self.string = string
    }

    let string: String

    func boundingBox(for range: Range<String.Index>) throws -> VNRectangleObservation? {
        VNRectangleObservation(boundingBox: .zero)
    }
}

private class StubTextDetector: TextDetector {
    override func recognizeText(in image: UIImage) async throws -> [Observations.RecognizedTextObservation] {
        return try [
            XCTUnwrap(RecognizedTextObservation("hello")),
            XCTUnwrap(RecognizedTextObservation("world")),
        ]
    }
}

private extension Observations.RecognizedTextObservation {
    init?(_ string: String) {
        let visionText = MockVisionText(string)
        let recognizedText = RecognizedText(recognizedText: visionText, uuid: UUID())
        self.init(recognizedText, imageSize: .zero)
    }
}

@available(iOS 16.0, *)
private class StubRedactExporter: ShortcutsRedactExporter {
    let exportExpectation: XCTestExpectation
    let expectedRedactionCount: Int

    init(exportExpectation: XCTestExpectation, expectedRedactionCount: Int) {
        self.exportExpectation = exportExpectation
        self.expectedRedactionCount = expectedRedactionCount
        super.init()
    }

    override func export(_ input: IntentFile, redactions: [Redaction]) async throws -> IntentFile {
        XCTAssertEqual(redactions.count, expectedRedactionCount)
        exportExpectation.fulfill()
        return input
    }
}
