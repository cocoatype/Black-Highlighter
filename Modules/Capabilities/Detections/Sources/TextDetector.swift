//  Created by Geoff Pado on 4/22/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import ObservationsMac
public typealias HighlighterRecognizedText = ObservationsMac.RecognizedText
public typealias HighlighterRecognizedTextObservation = ObservationsMac.RecognizedTextObservation
#elseif canImport(UIKit)
import Observations
import UIKit
public typealias HighlighterRecognizedText = Observations.RecognizedText
public typealias HighlighterRecognizedTextObservation = Observations.RecognizedTextObservation
#endif

import Vision

open class TextDetector: NSObject {
    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    public func detectTextRectangles(in image: NSImage, completionHandler: (([TextRectangleObservation]?) -> Void)? = nil) {
        guard let detectionOperation = TextRectangleDetectionOperation(image: image) else {
            completionHandler?(nil)
            return
        }

        detectionOperation.completionBlock = { [weak detectionOperation] in
            let detectedTextObservations = detectionOperation?.textRectangleResults?.map { TextRectangleObservation($0, in: image) }
            completionHandler?(detectedTextObservations)
        }

        operationQueue.addOperation(detectionOperation)
    }
    #elseif canImport(UIKit)
    public func detectTextRectangles(in image: UIImage, completionHandler: (([TextRectangleObservation]?) -> Void)? = nil) {
        guard let detectionOperation = TextRectangleDetectionOperation(image: image) else {
            completionHandler?(nil)
            return
        }

        detectionOperation.completionBlock = { [weak detectionOperation] in
            let detectedTextObservations = detectionOperation?.textRectangleResults?.map { TextRectangleObservation($0, in: image) }
            completionHandler?(detectedTextObservations)
        }

        operationQueue.addOperation(detectionOperation)
    }
    #endif

    private func detectRecognitions(with operation: TextRecognitionOperation) async -> [HighlighterRecognizedText] {
        return await withCheckedContinuation { continuation in
            operation.completionBlock = { [weak operation] in
                // Detect all text in image.
                guard let operation = operation, let results = operation.recognizedTextResults else { return }

                let candidates = results.compactMap { result -> HighlighterRecognizedText? in
                    // For every observation, get the top candidate.
                    guard let topCandidate = result.topCandidates(1).first else {
                        assertionFailure("had zero top candidates")
                        return nil
                    }
                    return RecognizedText(recognizedText: topCandidate, uuid: result.uuid)
                }

                continuation.resume(returning: candidates)
            }

            operationQueue.addOperation(operation)
        }
    }

    private func detectText(with operation: TextRecognitionOperation) async -> [HighlighterRecognizedTextObservation] {
        await detectRecognitions(with: operation)
            .compactMap {
                RecognizedTextObservation($0, imageSize: operation.imageSize)
            }
    }

    private func detectWords(with operation: TextRecognitionOperation) async -> [WordObservation] {
        return await detectText(with: operation)
            .flatMap(\.allWordObservations)
    }

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    @available(macOS 10.15, *)
    public func detectWords(in image: NSImage, completionHandler: @escaping (([WordObservation]?) -> Void)) {
        guard let recognitionOperation = try? TextRecognitionOperation(image: image) else { return completionHandler(nil) }
        Task {
            await completionHandler(detectWords(with: recognitionOperation))
        }
    }

    public func detectText(in image: NSImage, completionHandler: @escaping (([RecognizedTextObservation]?) -> Void)) {
        guard let recognitionOperation = try? TextRecognitionOperation(image: image) else { return completionHandler(nil) }
        Task {
            await completionHandler(detectText(with: recognitionOperation))
        }
    }
    #elseif canImport(UIKit)
    public func detectWords(in image: UIImage, completionHandler: @escaping (([WordObservation]?) -> Void)) {
        guard let recognitionOperation = try? TextRecognitionOperation(image: image) else { return completionHandler(nil) }
        Task {
            await completionHandler(detectWords(with: recognitionOperation))
        }
    }

    open func detectText(in image: UIImage) async throws -> [HighlighterRecognizedTextObservation] {
        let recognitionOperation = try TextRecognitionOperation(image: image)
        return await detectText(with: recognitionOperation)
    }

    public func detectText(in image: UIImage, completionHandler: @escaping (([HighlighterRecognizedTextObservation]?) -> Void)) {
        Task {
            await completionHandler(try? detectText(in: image))
        }
    }
    #endif

    // MARK: Boilerplate

    private let operationQueue = OperationQueue()
}

public enum TextDetectorError {
    case cannotCreateOperation
}
