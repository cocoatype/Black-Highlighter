//  Created by Geoff Pado on 11/30/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

struct ColorRenderer {
    private func darkerColor(for color: UIColor) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        // Convert to HSB (HSV) color space
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        // Create new color with brightness at 80% of original
        return UIColor(hue: hue,
                      saturation: saturation,
                      brightness: brightness * 0.8,
                      alpha: alpha)
    }

    func data(for color: UIColor) throws -> Data {
        let imageSize = CGSize(width: 24, height: 24)
        let strokeColor = darkerColor(for: color)
        let image = UIGraphicsImageRenderer(size: imageSize).image { context in
            strokeColor.setStroke()
            color.setFill()

            let fillRect = CGRect(origin: .zero, size: imageSize)
            UIBezierPath(ovalIn: fillRect).fill()

            let strokeRect = fillRect.insetBy(dx: 0.5, dy: 0.5)
            UIBezierPath(ovalIn: strokeRect).stroke()
        }

        guard let data = image.pngData() else { throw ColorRenderer.Error.cannotGetImageData }

        return data
    }

    enum Error: Swift.Error {
        case cannotGetImageData
    }
}
