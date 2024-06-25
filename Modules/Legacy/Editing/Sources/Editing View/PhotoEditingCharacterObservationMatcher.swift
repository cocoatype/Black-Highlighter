//  Created by Geoff Pado on 6/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Observations

extension [CharacterObservation] {
    func matching(_ text: String) -> [CharacterObservation] {
        return filter { characterObservation -> Bool in
            guard let associatedWord = characterObservation.associatedWord else { return false }

            let trimmedText = text.trimmingCharacters(in: .alphanumerics.inverted)
            let trimmedAssociatedWord = associatedWord.trimmingCharacters(in: .alphanumerics.inverted)
            return trimmedAssociatedWord.compare(trimmedText, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
        }
    }
}
