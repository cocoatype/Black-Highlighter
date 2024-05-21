//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import CoreGraphics

public extension CGSize {
    static func * (size: CGSize, multiplier: CGFloat) -> CGSize {
        return CGSize(width: size.width * multiplier, height: size.height * multiplier)
    }

    var integral: CGSize {
        CGSize(width: floor(width), height: floor(height))
    }
}
