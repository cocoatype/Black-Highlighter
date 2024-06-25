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
            let intersectingRecognizedObservation = recognizedCharacterObservations.first(where: { recognizedObservation in
                let recognizedPath = recognizedObservation.bounds.path

                let isEqual = detectedPath.isEqual(to: recognizedPath, accuracy: 0.01)
                guard isEqual == false else {
                    return true
                }

                return finder.intersectionExists(between: detectedPath, and: recognizedPath)
            })

            if let intersectingRecognizedObservation {
                var siblingObservations = currentPass.recognizedObservations[intersectingRecognizedObservation] ?? []
                siblingObservations.append(detectedObservation)
                currentPass.recognizedObservations[intersectingRecognizedObservation] = siblingObservations
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

        // find recognized observations that are insufficiently filled to count
        let unfulfilledObservations = calculationPass.recognizedObservations.filter { parent, children in
            let childArea = children.reduce(Double.zero) { childArea, observation in
                childArea + observation.bounds.path.area()
            }
            let parentArea = parent.bounds.path.area()
            return childArea < (parentArea * 0.35)
        }.keys

        // combine the remaining parent observations and their children
        let remainingObservations = calculationPass.recognizedObservations.filter { parent, _ in
            unfulfilledObservations.contains(parent) == false
        }
        let combinedObservations = remainingObservations.map { parent, children in
            let combinedShape = MinimumAreaShapeFinder.minimumAreaShape(for: children.map(\.bounds))

            return CharacterObservation(bounds: combinedShape, textObservationUUID: parent.textObservationUUID, associatedString: parent.associatedString, range: parent.range)
        }

        return combinedObservations + childlessObservations + unfulfilledObservations + calculationPass.orphanedObservations
    }

    var calculatedObservationsByUUID: [UUID: [CharacterObservation]] {
        return calculatedObservations.reduce([UUID: [CharacterObservation]]()) { dictionary, observation in
            var observationsByUUID: [CharacterObservation]
            if let existing = dictionary[observation.textObservationUUID] {
                observationsByUUID = existing
            } else {
                observationsByUUID = []
            }

            observationsByUUID.append(observation)

            var newDictionary = dictionary
            newDictionary[observation.textObservationUUID] = observationsByUUID
            return newDictionary
        }
    }
}
