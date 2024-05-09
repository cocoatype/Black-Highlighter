//  Created by Geoff Pado on 5/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import CoreGraphics

extension CGPoint {
    static func flippedPoint(from point: CGPoint, scaledTo size: CGSize) -> CGPoint {
        var scaledPoint = point

        #if canImport(UIKit)
        scaledPoint.y = (1.0 - scaledPoint.y)
        #endif

        scaledPoint.x *= size.width
        scaledPoint.y *= size.height

        return scaledPoint
    }
}
