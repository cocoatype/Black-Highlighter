//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(UIKit)
import UIKit

extension UIImage {
    func cgImage(scale: CGFloat) -> CGImage? {
        guard abs(scale - self.scale) >= 0.01
        else { return cgImage }

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let scaledImage = UIGraphicsImageRenderer(size: size, format: format).image { _ in
            self.draw(at: .zero)
        }
        return scaledImage.cgImage
    }
}
#endif
