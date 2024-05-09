//  Created by Geoff Pado on 5/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

public struct CharacterObservation: Hashable {
    public let bounds: Shape
    public let textObservationUUID: UUID
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
