//  Created by Geoff Pado on 5/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(UIKit) && targetEnvironment(macCatalyst)
import UIKit

extension UIImage.Orientation {
    var cgImagePropertyOrientation: CGImagePropertyOrientation {
        switch self {
        case .up: return .up
        case .down: return .down
        case .left: return .left
        case .right: return .right
        case .upMirrored: return .upMirrored
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .rightMirrored: return .rightMirrored
        @unknown default: return .up
        }
    }
}
#endif
