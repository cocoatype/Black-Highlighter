//  Created by Geoff Pado on 6/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Observations
import Redactions

actor PhotoEditingObservationCalculator {
    private let detectedTextObservations: [RedactableObservation]
    private let recognizedTextObservations: [RedactableObservation]
    private let color: UIColor
    private let finder: PhotoEditingIntersectionFinder

    init(detectedTextObservations: [RedactableObservation], recognizedTextObservations: [RedactableObservation], color: UIColor) {
        self.detectedTextObservations = detectedTextObservations
        self.recognizedTextObservations = recognizedTextObservations
        self.color = color

        if #available(iOS 16.0, *) {
            self.finder = PhotoEditingSystemIntersectionFinder()
        } else {
            self.finder = PhotoEditingLibraryIntersectionFinder()
        }
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
