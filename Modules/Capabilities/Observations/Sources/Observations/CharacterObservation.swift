//  Created by Geoff Pado on 5/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import GeometryMac
#elseif canImport(UIKit)
import Geometry
#endif

public struct CharacterObservation: Hashable, RedactableObservation {
    public let bounds: Shape
    public let textObservationUUID: UUID

    public var characterObservations: [CharacterObservation] { [self] }

    public init(bounds: Shape, textObservationUUID: UUID) {
        self.bounds = bounds
        self.textObservationUUID = textObservationUUID
    }
}
