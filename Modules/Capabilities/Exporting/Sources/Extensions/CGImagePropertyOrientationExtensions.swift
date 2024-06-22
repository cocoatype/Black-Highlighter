//  Created by Geoff Pado on 6/21/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ImageIO

extension CGImagePropertyOrientation {
    var rotationAngle: Double {
        switch self {
        case .up: return 0
        case .down: return .pi
        case .left: return  -1 * .pi / 2
        case .right: return .pi / 2
        case .upMirrored: return 0
        case .downMirrored: return .pi
        case .leftMirrored: return .pi / 2
        case .rightMirrored: return -1 * .pi / 2
        @unknown default: return 0
        }
    }
}
