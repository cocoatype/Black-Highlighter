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

        // find where all detected observations belong
        let calculationPass = detectedCharacterObservations.reduce(into: PhotoEditingObservationCalculationPass()) { currentPass, detectedObservation in
            let detectedPath = detectedObservation.bounds.path
            let intersectingObservation = recognizedCharacterObservations.first(where: { recognizedObservation in
                let recognizedPath = recognizedObservation.bounds.path

                let isEqual = detectedPath.isEqual(to: recognizedPath, accuracy: 0.01)
                guard isEqual == false else {
                    return true
                }

                return finder.intersectionExists(between: detectedPath, and: recognizedPath)
            })

            if let intersectingObservation {
                var siblingObservations = currentPass.recognizedObservations[intersectingObservation] ?? []
                siblingObservations.append(detectedObservation)
                currentPass.recognizedObservations[intersectingObservation] = siblingObservations
            } else {
                currentPass.orphanedObservations.append(detectedObservation)
            }
        }

        // find recognized observations with no related detected observations
        let parentObservations = calculationPass.recognizedObservations.keys
        let childlessObservations = recognizedCharacterObservations.filter { recognizedObservation in
            let isParent = parentObservations.contains(recognizedObservation)
            return isParent == false
        }

        // combine the parent observations and their children
        let combinedObservations = calculationPass.recognizedObservations.map { parent, children in
            var children = children
            let firstShape = children.removeFirst().bounds
            let combinedShape = children.reduce(into: firstShape) { combinedShape, observation in
                combinedShape = combinedShape.union(observation.bounds)
            }

            return CharacterObservation(bounds: combinedShape, textObservationUUID: parent.textObservationUUID)
        }

        return combinedObservations + childlessObservations + calculationPass.orphanedObservations
    }
}
