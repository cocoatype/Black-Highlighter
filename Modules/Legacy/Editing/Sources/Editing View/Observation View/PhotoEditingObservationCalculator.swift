//  Created by Geoff Pado on 6/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
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
        let filteredDetectedObservations = detectedCharacterObservations.filter { detectedObservation in
            let detectedCGPath = detectedObservation.bounds.path

            let hasIntersection = recognizedCharacterObservations.contains { recognizedObservation in
                let recognizedCGPath = recognizedObservation.bounds.path

                let isEqual = detectedCGPath.isEqual(to: recognizedCGPath, accuracy: 0.01)
                guard isEqual == false else { return true }

                let isContained = detectedCGPath.contains(recognizedCGPath.currentPoint) || recognizedCGPath.contains(detectedCGPath.currentPoint)
                guard isContained == false else { return true }

                return finder.intersectionExists(between: detectedCGPath, and: recognizedCGPath)
            }

            return !hasIntersection
        }

        // unique by adding to set
        let characterObservationSet = Set(filteredDetectedObservations + recognizedCharacterObservations)

        return Array(characterObservationSet)
    }
}
