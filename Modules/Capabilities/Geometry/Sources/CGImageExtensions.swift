//  Created by Geoff Pado on 2/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreGraphics

public extension CGImage {
    var size: CGSize {
        CGSize(width: Double(width), height: Double(height))
    }
}
