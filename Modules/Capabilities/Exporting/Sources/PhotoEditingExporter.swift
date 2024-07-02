//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Redactions
import Rendering
import UIKit
import UniformTypeIdentifiers

public class PhotoEditingExporter {
    private let image: UIImage
    private let redactions: [Redaction]
    public init(image: UIImage, redactions: [Redaction]) {
        self.image = image
        self.redactions = redactions
    }

    @MainActor public func presentActivityController(from hostViewController: UIViewController, barButtonItem: UIBarButtonItem) async throws {
        let exportedImage = try await PhotoExporter.export(image, redactions: redactions)

        let representedURLName = "\(ExportingStrings.PhotoEditingExporter.defaultImageName).\(imageType?.preferredFilenameExtension ?? "png")"
        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(representedURLName)
        
        let data: Data?

        switch imageType {
        case .jpeg?:
            data = exportedImage.jpegData(compressionQuality: 0.9)
        default:
            data = exportedImage.pngData()
        }

        let activityItems: [Any]
        if let data = data, (try? data.write(to: temporaryURL)) != nil {
            activityItems = [temporaryURL]
        } else {
            activityItems = [exportedImage]
        }


        return await withCheckedContinuation { continuation in
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityController.completionWithItemsHandler = { [weak self] _, _, _, _ in
                continuation.resume()
            }

            activityController.popoverPresentationController?.barButtonItem = barButtonItem
            hostViewController.present(activityController, animated: true)
        }
    }

    public var imageType: UTType? {
        guard let imageTypeString = image.cgImage?.utType
        else { return nil }

        return UTType(imageTypeString as String)
    }
}
