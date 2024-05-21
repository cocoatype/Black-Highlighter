//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIImage {
    public var realSize: CGSize {
        switch imageOrientation {
        case .up, .down, .upMirrored, .downMirrored:
            return size
        case .left, .right, .leftMirrored, .rightMirrored:
            return CGSize(width: size.height, height: size.width)
        @unknown default:
            return size
        }
    }
}

extension UIImage.Orientation {
    public var rotationAngle: CGFloat {
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

