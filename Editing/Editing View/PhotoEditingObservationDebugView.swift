//  Created by Geoff Pado on 7/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

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

    private func updateDebugLayers() {
        layer.sublayers = debugLayers
    }

    private var debugLayers: [CALayer] {
        guard let textObservations = textObservations else { return [] }
        return textObservations.flatMap { textObservation -> [CALayer] in
            guard let characterObservations = textObservation.characterObservations else { return [] }
            let characterLayers = characterObservations.map { observation in
                let layer = CALayer()
                layer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
                layer.frame = observation.bounds
                return layer
            }

            let textLayer = CALayer()
            textLayer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3).cgColor
            textLayer.frame = textObservation.bounds

            return characterLayers + [textLayer]
        }
    }
}
