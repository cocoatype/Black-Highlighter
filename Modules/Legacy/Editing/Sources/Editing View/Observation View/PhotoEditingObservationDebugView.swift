//  Created by Geoff Pado on 7/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

@_implementationOnly import ClippingBezier
import Observations
import UIKit

class PhotoEditingObservationDebugView: PhotoEditingRedactionView {
    override init() {
        super.init()
        isUserInteractionEnabled = false
    }

    // MARK: Text Observations

    var textObservations: [TextRectangleObservation]? {
        didSet {
            updateDebugLayers()
            setNeedsDisplay()
        }
    }

    var recognizedTextObservations: [RecognizedTextObservation]? {
        didSet {
            updateDebugLayers()
            setNeedsDisplay()
        }
    }

    private func updateDebugLayers() {
        Task {
            layer.sublayers = await debugLayers
        }
    }

    private var debugLayers: [CAShapeLayer] {
        get async {
            guard FeatureFlag.shouldShowDebugOverlay, let textObservations, let recognizedTextObservations else { return [] }

            // find words (new system)
            let wordLayers = recognizedTextObservations.map { wordObservation in
                let outlineLayer = CAShapeLayer()
                outlineLayer.fillColor = UIColor.systemGreen.withAlphaComponent(0.0).cgColor
                outlineLayer.frame = bounds
                outlineLayer.path = wordObservation.path
                return outlineLayer
            }

            // find text (old system)
            let textLayers = textObservations.flatMap { textObservation -> [CAShapeLayer] in
                let characterObservations = textObservation.characterObservations
                let characterLayers = characterObservations.map { observation -> CAShapeLayer in
                    let layer = CAShapeLayer()
                    layer.fillColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
                    layer.frame = bounds
                    layer.path = observation.bounds.path
                    return layer
                }

                let textLayer = CAShapeLayer()
                textLayer.fillColor = UIColor.systemRed.withAlphaComponent(0.3).cgColor
                textLayer.frame = bounds
                textLayer.path = CGPath(rect: textObservation.bounds.boundingBox, transform: nil)

                return characterLayers + [textLayer]
            }

            let calculator = PhotoEditingObservationCalculator(detectedTextObservations: textObservations, recognizedTextObservations: recognizedTextObservations)
            let characterObservations = await calculator.calculatedObservations
            let wordCharacterLayers = characterObservations.map { (characterObservation: CharacterObservation) -> CAShapeLayer in
                let textLayer = CAShapeLayer()
                textLayer.fillColor = UIColor.systemYellow.withAlphaComponent(0.0).cgColor
                textLayer.frame = bounds
                textLayer.path = characterObservation.bounds.path
                return textLayer
            }

            return textLayers + wordLayers + wordCharacterLayers
        }
    }
}
