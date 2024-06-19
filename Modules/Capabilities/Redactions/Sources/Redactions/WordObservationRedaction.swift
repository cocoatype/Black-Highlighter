//  Created by Geoff Pado on 5/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if canImport(UIKit)
import Geometry
import Observations
import UIKit

extension Redaction {
    public init(_ wordObservations: [WordObservation], color: UIColor) {
        let parts = wordObservations.reduce(into: [UUID: [WordObservation]]()) { result, wordObservation in
            let textObservationUUID = wordObservation.textObservationUUID
            var siblingObservations = result[textObservationUUID] ?? []
            siblingObservations.append(wordObservation)
            result[textObservationUUID] = siblingObservations
        }.values.map { siblingObservations in
            MinimumAreaShapeFinder.minimumAreaShape(for: siblingObservations.map(\.bounds))
        }.map(RedactionPart.shape)

        self.init(color: color, parts: parts)
    }
}
#endif
