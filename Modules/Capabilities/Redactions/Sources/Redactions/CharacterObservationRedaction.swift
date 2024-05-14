//  Created by Geoff Pado on 5/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if targetEnvironment(macCatalyst) || os(iOS)
import Observations
import UIKit

extension Redaction {
    public init?(_ characterObservations: [CharacterObservation], color: UIColor) {
        guard characterObservations.count > 0 else { return nil }

        let parts = characterObservations.reduce(into: [UUID: [CharacterObservation]]()) { result, characterObservation in
            let textObservationUUID = characterObservation.textObservationUUID
            var siblingObservations = result[textObservationUUID] ?? []
            siblingObservations.append(characterObservation)
            result[textObservationUUID] = siblingObservations
        }.values.map { siblingObservations in
            siblingObservations.reduce(siblingObservations[0].bounds, { currentRect, characterObservation in
                currentRect.union(characterObservation.bounds)
            })
        }.map(RedactionPart.shape)

        self.init(color: color, parts: parts)
    }
}
#else
import AppKit
import ObservationsNative

extension Redaction {
    public init?(_ characterObservations: [CharacterObservation], color: NSColor) {
        guard characterObservations.count > 0 else { return nil }

        let parts = characterObservations.reduce(into: [UUID: [CharacterObservation]]()) { result, characterObservation in
            let textObservationUUID = characterObservation.textObservationUUID
            var siblingObservations = result[textObservationUUID] ?? []
            siblingObservations.append(characterObservation)
            result[textObservationUUID] = siblingObservations
        }.values.map { siblingObservations in
            siblingObservations.reduce(siblingObservations[0].bounds, { currentRect, characterObservation in
                currentRect.union(characterObservation.bounds)
            })
        }.map(RedactionPart.shape)

        self.init(color: color, parts: parts)
    }
}
#endif
