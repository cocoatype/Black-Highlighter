//  Created by Geoff Pado on 5/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import GeometryMac
#elseif canImport(UIKit)
import Geometry
#endif

public struct CharacterObservation: TextObservation, Hashable, RedactableObservation {
    public let bounds: Shape
    public let textObservationUUID: UUID
    public let associatedString: String?
    public let range: Range<String.Index>?

    public var characterObservations: [CharacterObservation] { [self] }

    public init(bounds: Shape, textObservationUUID: UUID, associatedString: String? = nil, range: Range<String.Index>? = nil) {
        self.bounds = bounds
        self.textObservationUUID = textObservationUUID
        self.associatedString = associatedString
        self.range = range
    }

    public var associatedWord: String? {
        guard let associatedString, let range else { return nil }
        return String(associatedString[range])
    }
}
