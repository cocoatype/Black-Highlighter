//  Created by Geoff Pado on 5/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import GeometryMac
#elseif canImport(UIKit)
import Geometry
#endif

public struct CharacterObservation: Hashable {
    public let bounds: Shape
    public let textObservationUUID: UUID
}
