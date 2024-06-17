//  Created by Geoff Pado on 6/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Geometry
import Observations
import Redactions

actor PhotoEditingObservationCalculator {
    private let detectedTextObservations: [RedactableObservation]
    private let recognizedTextObservations: [RedactableObservation]
    private let finder: any PhotoEditingIntersectionFinder = {
        if #available(iOS 16.0, *) {
            return PhotoEditingSystemIntersectionFinder()
        } else {
            return PhotoEditingLibraryIntersectionFinder()
        }
    }()

    init(detectedTextObservations: [RedactableObservation], recognizedTextObservations: [RedactableObservation]) {
        self.detectedTextObservations = detectedTextObservations
        self.recognizedTextObservations = recognizedTextObservations
    }

    var calculatedObservations: [CharacterObservation] {
        // get all character observations from recognized text
        let recognizedCharacterObservations = recognizedTextObservations.flatMap(\.characterObservations).filter(\.bounds.isNotZero)

        // get all character observations from detected text
        let detectedCharacterObservations = detectedTextObservations.flatMap(\.characterObservations).filter(\.bounds.isNotZero)

        // do intersection detection to override detected with recognized text
        let calculatedObservations = recognizedCharacterObservations.reduce(into: [CharacterObservation]()) { calculatedObservations, recognizedObservation in
            let recognizedPath = recognizedObservation.bounds.path
            var intersectingObservations = detectedCharacterObservations.filter { detectedObservation in
                let detectedPath = detectedObservation.bounds.path

                let isEqual = detectedPath.isEqual(to: recognizedPath, accuracy: 0.01)
                guard isEqual == false else {
                    return true
                }

                return finder.intersectionExists(between: detectedPath, and: recognizedPath)
            }

            guard intersectingObservations.count > 0 else { return }

            let firstShape = intersectingObservations.removeFirst().bounds
            let intersectingObservationsShape = intersectingObservations.reduce(into: firstShape) { combinedShape, observation in
                combinedShape = combinedShape.union(observation.bounds)
            }

            calculatedObservations.append(CharacterObservation(bounds: intersectingObservationsShape, textObservationUUID: recognizedObservation.textObservationUUID))
        }

        return calculatedObservations
    }
}
