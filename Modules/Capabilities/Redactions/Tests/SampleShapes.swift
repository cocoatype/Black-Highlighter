//  Created by Geoff Pado on 5/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Geometry

extension Shape {
    static let emptySample = Shape(
        bottomLeft: CGPoint(x: 5, y: 5),
        bottomRight: CGPoint(x: 5, y: 5),
        topLeft: CGPoint(x: 5, y: 5),
        topRight: CGPoint(x: 5, y: 5)
    )

    static let sample = Shape(
        bottomLeft: CGPoint(x: 0, y: 5),
        bottomRight: CGPoint(x: 5, y: 5),
        topLeft: CGPoint(x: 0, y: 0),
        topRight: CGPoint(x: 5, y: 0)
    )
}
