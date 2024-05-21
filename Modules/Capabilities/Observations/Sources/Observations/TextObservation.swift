//  Created by Geoff Pado on 4/22/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import GeometryMac
#elseif canImport(UIKit)
import Geometry
#endif

import CoreGraphics

public protocol TextObservation: Equatable {
    var bounds: Shape { get }
}

public extension TextObservation {
    var path: CGPath { bounds.path }
}
