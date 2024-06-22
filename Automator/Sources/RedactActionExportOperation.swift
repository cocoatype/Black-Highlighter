//  Created by Geoff Pado on 10/28/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import AppKit
import BrushesMac
import Redacting
import RedactionsMac

//class RedactActionExportOperation: Operation {
//    var result: Result<String, Error>?
//
//    init(input: RedactActionInput, redactions: [Redaction]) {
//        self.redactions = redactions
//        self.input = input
//    }
//
//    #warning("#62: Simplify & de-dupe")
//    // swiftlint:disable:next function_body_length
//    override func main() {
//        do {
//
//            // draw redactions
//            let drawings = redactions.flatMap { redaction -> [(path: NSBezierPath, color: NSColor)] in
//                return redaction.paths
//                  .map { (path: $0, color: redaction.color) }
//            }
//
//            drawings.forEach { drawing in
//                let (path, color) = drawing
//                let borderBounds = path.strokeBorderPath.bounds
//                let startImage = BrushStampFactory.brushStart(scaledToHeight: borderBounds.height, color: color)
//                let endImage = BrushStampFactory.brushEnd(scaledToHeight: borderBounds.height, color: color)
//
//                color.setFill()
//                NSBezierPath(rect: borderBounds).fill()
//
//                let drawContext = NSGraphicsContext(cgContext: context, flipped: false)
//                NSGraphicsContext.saveGraphicsState()
//                NSGraphicsContext.current = drawContext
//                let startRect = CGRect(origin: borderBounds.origin, size: startImage.size).offsetBy(dx: -startImage.size.width, dy: 0)
//                startImage.draw(in: startRect, from: CGRect(origin: .zero, size: startImage.size), operation: .sourceOver, fraction: 1)
//
//                let endRect = CGRect(origin: borderBounds.origin, size: endImage.size).offsetBy(dx: borderBounds.width, dy: 0)
//                endImage.draw(in: endRect, from: CGRect(origin: .zero, size: endImage.size), operation: .sourceOver, fraction: 1)
//                NSGraphicsContext.restoreGraphicsState()
//            }
//
//            // export image
//            let writeURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString).appendingPathExtension(input.fileType?.preferredFilenameExtension ?? "png")
//
//            guard let data = imageRep.representation(using: input.imageType, properties: [:]) else { throw RedactActionExportError.writeError }
//            try data.write(to: writeURL)
//
//            self.result = .success(writeURL.path)
//        } catch {
//            self.result = .failure(error)
//        }
//    }
//
//    // MARK: Boilerplate
//
//    private static let bytesPerMB = 1024 * 1024
//    private static let bytesPerPixel = 4
//    private static let pixelsPerMB = bytesPerMB / bytesPerPixel
//    private static let seamOverlap = CGFloat(2)
//    private static let sourceImageTileSizeMB = 120
//    private static let tileTotalPixels = sourceImageTileSizeMB * pixelsPerMB
//
//    private let redactions: [Redaction]
//    private let input: RedactActionInput
//}
