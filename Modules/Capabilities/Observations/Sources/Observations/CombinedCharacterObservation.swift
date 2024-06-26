//  Created by Geoff Pado on 6/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

public struct CombinedCharacterObservation {
    public let textObservationUUID: UUID
    private let characterObservations: [CharacterObservation]
    public let associatedString: String

    public init?(characterObservations: [CharacterObservation]) {
        guard let firstUUID = characterObservations.first?.textObservationUUID,
              characterObservations.allSatisfy({ $0.textObservationUUID == firstUUID }),
              let firstString = characterObservations.first?.associatedString
        else { return nil }

        self.textObservationUUID = firstUUID
        self.characterObservations = characterObservations
        self.associatedString = firstString
    }

    public func characterObservations(with substrings: [Substring]) -> [CharacterObservation] {
        characterObservations.filter { observation in
            guard let observationRange = observation.range else { return false }
            return substrings.contains { substring in
                let substringRange = substring.startIndex ..< substring.endIndex
                return observationRange.overlaps(substringRange)
            }
        }
    }
}
