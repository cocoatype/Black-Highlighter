//  Created by Geoff Pado on 10/28/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import AppKit
import Redacting
import RedactionsNative

class RedactActionExportOperation: Operation {
    var result: Result<String, Error>?

    init(input: RedactActionInput, redactions: [Redaction]) {
        self.redactions = redactions
        self.input = input
    }

    private lazy var sourceImageRep: NSBitmapImageRep? = {
        guard let sourceImage = input.image, let imageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(sourceImage.size.width), pixelsHigh: Int(sourceImage.size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: Int(sourceImage.size.width) * 4, bitsPerPixel: 32) else { return nil }

        let context = NSGraphicsContext(bitmapImageRep: imageRep)
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = context
        sourceImage.draw(at: .zero, from: CGRect(origin: .zero, size: sourceImage.size), operation: .copy, fraction: 1)
        NSGraphicsContext.restoreGraphicsState()
        return imageRep
    }()

    #warning("#62: Simplify & de-dupe")
    // swiftlint:disable:next function_body_length
    override func main() {
        do {
            guard let sourceImage = input.image else { throw RedactActionExportError.noImageForInput }
            let imageSize = sourceImage.size

            guard let imageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(imageSize.width), pixelsHigh: Int(imageSize.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: Int(imageSize.width) * 4, bitsPerPixel: 32), let graphicsContext = NSGraphicsContext(bitmapImageRep: imageRep) else { throw RedactActionExportError.failedToGenerateGraphicsContext }
            let context = graphicsContext.cgContext

            var tileRect = CGRect.zero
            tileRect.size.width = imageSize.width
            tileRect.size.height = floor(CGFloat(Self.tileTotalPixels) / CGFloat(imageSize.width))

            let remainder = imageSize.height.truncatingRemainder(dividingBy: tileRect.height)
            let baseIterationCount = Int(imageSize.height / tileRect.height)
            let iterationCount = (remainder > 1) ? baseIterationCount + 1 : baseIterationCount

            let overlappingTileRect = CGRect(x: tileRect.minX, y: tileRect.minY, width: tileRect.width, height: tileRect.height + Self.seamOverlap)

            // draw tiles of source image
            context.saveGState()

            for y in 0..<iterationCount {
                autoreleasepool {
                    var currentTileRect = overlappingTileRect
                    currentTileRect.origin.y = CGFloat(y) * (tileRect.size.height + Self.seamOverlap)

                    if y == iterationCount - 1 && remainder > 0 {
                        let diffY = currentTileRect.maxY - imageSize.height
                        currentTileRect.size.height -= diffY
                    }

                    if let imageRef = sourceImageRep?.cgImage?.cropping(to: currentTileRect) {
                        context.draw(imageRef, in: currentTileRect)
                    }
                }
            }

            context.restoreGState()

            // draw redactions
            let drawings = redactions.flatMap { redaction -> [(path: NSBezierPath, color: NSColor)] in
                return redaction.paths
                  .map { (path: $0, color: redaction.color) }
            }

            drawings.forEach { drawing in
                let (path, color) = drawing
                let borderBounds = path.strokeBorderPath.bounds
                let startImage = BrushStampFactory.brushStart(scaledToHeight: borderBounds.height, color: color)
                let endImage = BrushStampFactory.brushEnd(scaledToHeight: borderBounds.height, color: color)

                color.setFill()
                NSBezierPath(rect: borderBounds).fill()

                let drawContext = NSGraphicsContext(cgContext: context, flipped: false)
                NSGraphicsContext.saveGraphicsState()
                NSGraphicsContext.current = drawContext
                let startRect = CGRect(origin: borderBounds.origin, size: startImage.size).offsetBy(dx: -startImage.size.width, dy: 0)
                startImage.draw(in: startRect, from: CGRect(origin: .zero, size: startImage.size), operation: .sourceOver, fraction: 1)

                let endRect = CGRect(origin: borderBounds.origin, size: endImage.size).offsetBy(dx: borderBounds.width, dy: 0)
                endImage.draw(in: endRect, from: CGRect(origin: .zero, size: endImage.size), operation: .sourceOver, fraction: 1)
                NSGraphicsContext.restoreGraphicsState()
            }

            // export image
            let writeURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString).appendingPathExtension(input.fileType?.preferredFilenameExtension ?? "png")

            guard let data = imageRep.representation(using: input.imageType, properties: [:]) else { throw RedactActionExportError.writeError }
            try data.write(to: writeURL)

            self.result = .success(writeURL.path)
        } catch {
            self.result = .failure(error)
        }
    }

    // MARK: Boilerplate

    private static let bytesPerMB = 1024 * 1024
    private static let bytesPerPixel = 4
    private static let pixelsPerMB = bytesPerMB / bytesPerPixel
    private static let seamOverlap = CGFloat(2)
    private static let sourceImageTileSizeMB = 120
    private static let tileTotalPixels = sourceImageTileSizeMB * pixelsPerMB

    private let redactions: [Redaction]
    private let input: RedactActionInput
}
