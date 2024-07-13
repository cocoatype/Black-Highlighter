//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos
import Redactions
import Rendering
import UIKit
import UniformTypeIdentifiers

public class PhotoEditingActivityController: UIActivityViewController {
    private let image: UIImage
    private let asset: PHAsset?
    private let redactions: [Redaction]

    public init(image: UIImage, asset: PHAsset?, redactions: [Redaction]) async throws {
        self.image = image
        self.asset = asset
        self.redactions = redactions

        let imageType = Self.imageType(for: asset, image: image)
        let exportedImage = try await PhotoExporter.export(image, redactions: redactions)

        let representedURLName = "\(ExportingStrings.PhotoEditingExporter.defaultImageName).\(imageType.preferredFilenameExtension ?? "png")"
        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(representedURLName)

        let data: Data?

        switch imageType {
        case .jpeg:
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

        super.init(activityItems: activityItems, applicationActivities: Self.applicationActivities(asset: asset, redactions: redactions))
        excludedActivityTypes = [.saveToCameraRoll]
    }

    static func applicationActivities(asset: PHAsset?, redactions: [Redaction]) -> [UIActivity] {
        if let asset {
            [SaveActivity(asset: asset, redactions: redactions), SaveCopyActivity()]
        } else {
            [SaveCopyActivity()]
        }
    }

    static func imageType(for asset: PHAsset?, image: UIImage) -> UTType {
        asset?.imageType ?? image.imageType ?? .png
    }
}

extension PHAsset {
    var imageType: UTType? {
        let resources = PHAssetResource.assetResources(for: self)

        guard let resource = resources.first(where: { $0.type == .photo })
        else { return nil }

        return UTType(resource.uniformTypeIdentifier)
    }
}
