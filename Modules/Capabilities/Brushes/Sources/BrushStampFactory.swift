//  Created by Geoff Pado on 7/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import ErrorHandlingMac
import GeometryMac

class BrushStampFactory: NSObject {
    static func brushStart(scaledToHeight height: CGFloat, color: NSColor) -> NSImage {
        guard let standardImage = Bundle(for: Self.self).image(forResource: "Brush Start") else { fatalError("Unable to load brush start image") }
        return scaledImage(from: standardImage, toHeight: height, color: color)
    }

    static func brushEnd(scaledToHeight height: CGFloat, color: NSColor) -> NSImage {
        guard let standardImage = Bundle(for: Self.self).image(forResource: "Brush End") else { fatalError("Unable to load brush end image") }
        return scaledImage(from: standardImage, toHeight: height, color: color)
    }

    private static func scaledImage(from image: NSImage, toHeight height: CGFloat, color: NSColor) -> NSImage {
        let brushScale = height / image.size.height
        let scaledBrushSize = image.size * brushScale

        return NSImage(size: scaledBrushSize, flipped: false) { _ -> Bool in
            color.setFill()

            CGRect(origin: .zero, size: scaledBrushSize).fill()

            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            context.scaleBy(x: brushScale, y: brushScale)

            image.draw(at: .zero, from: CGRect(origin: .zero, size: image.size), operation: .destinationIn, fraction: 1)

            return true
        }
    }
}
#elseif canImport(UIKit)
import ErrorHandling
import Geometry
import UIKit

public enum BrushStampFactory {
    public static func brushImages(for shape: Shape, color: UIColor, scale: CGFloat) throws -> (CGImage, CGImage) {
        let height = shape.unionDotShapeDotShapeDotUnionCrash.geometryStreamer.height
        let startImage = BrushStampFactory.brushStart(scaledToHeight: height, color: color)
        let endImage = BrushStampFactory.brushEnd(scaledToHeight: height, color: color)

        guard let startCGImage = startImage.cgImage(scale: scale),
              let endCGImage = endImage.cgImage(scale: scale)
        else {
            throw BrushStampFactoryError.cannotGenerateCGImage(
                shape: shape,
                color: color,
                scale: scale
            )
        }

        return (startCGImage, endCGImage)
    }

    private static func brushStart(scaledToHeight height: CGFloat, color: UIColor) -> UIImage {
        guard let startImage = UIImage(named: "Brush Start", in: .module, compatibleWith: nil)
        else { ErrorHandler().crash("Unable to load brush start image") }

        let brushScale = height / startImage.size.height
        let scaledBrushSize = (startImage.size * brushScale).integral

        return UIGraphicsImageRenderer(size: scaledBrushSize).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: scaledBrushSize))

            let cgContext = context.cgContext
            cgContext.scaleBy(x: brushScale, y: brushScale)

            startImage.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        }
    }

    private static func brushEnd(scaledToHeight height: CGFloat, color: UIColor) -> UIImage {
        guard let endImage = UIImage(named: "Brush End", in: .module, compatibleWith: nil)
        else { ErrorHandler().crash("Unable to load brush end image") }

        let brushScale = height / endImage.size.height
        let scaledBrushSize = (endImage.size * brushScale).integral

        return UIGraphicsImageRenderer(size: scaledBrushSize).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: scaledBrushSize))

            let cgContext = context.cgContext
            cgContext.scaleBy(x: brushScale, y: brushScale)

            endImage.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        }
    }

    public static func brushStamp(scaledToHeight height: CGFloat, color: UIColor) -> UIImage {
        guard let stampImage = UIImage(named: "Brush") else { ErrorHandler().crash("Unable to load brush stamp image") }

        let brushScale = height / stampImage.size.height
        let scaledBrushSize = stampImage.size * brushScale

        return UIGraphicsImageRenderer(size: scaledBrushSize).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: scaledBrushSize))

            let cgContext = context.cgContext
            cgContext.scaleBy(x: brushScale, y: brushScale)

            stampImage.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        }
    }
}

enum BrushStampFactoryError: Error {
    case cannotGenerateCGImage(shape: Shape, color: UIColor, scale: CGFloat)
}
#endif
