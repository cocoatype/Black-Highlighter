//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Geometry
import Photos
import Redactions
import UIKit

class SaveActivity: UIActivity {
    private let asset: PHAsset
    private let redactions: [Redaction]
    init(asset: PHAsset, redactions: [Redaction]) {
        self.asset = asset
        self.redactions = redactions
    }

    override var activityTitle: String? {
        ExportingStrings.SaveActivity.title
    }

    override var activityImage: UIImage? {
        ExportingAsset.save.image
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return activityItems.count == 1 && activityItems.first is URL
    }

    private var activityURL: URL?
    override func prepare(withActivityItems activityItems: [Any]) {
        activityURL = activityItems.first as? URL
    }

    override func perform() {
        guard let activityURL else { return ErrorHandler().log(SaveActivityError.noActivityURL) }

        asset.requestContentEditingInput(with: nil) { [weak self] contentEditingInput, dict in
            Task { [weak self] in
                do {
                    guard let asset = self?.asset,
                          let redactions = self?.redactions,
                          let input = contentEditingInput
                    else { throw SaveActivityError.noInputProvided }

                    let output = PHContentEditingOutput(contentEditingInput: input)
                    guard let formatVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { throw SaveActivityError.missingBundleVersion }
                    let data = try JSONEncoder().encode(SaveActivityAdjustmentData(redactions: redactions))
                    output.adjustmentData = PHAdjustmentData(formatIdentifier: SaveActivityAdjustmentData.formatIdentifier, formatVersion: formatVersion, data: data)
                    let (renderedContentURL, renderType) = output.renderingInformation

                    guard let image = UIImage(contentsOfFile: activityURL.path) else { throw SaveActivityError.failedImageDecode }
                    guard let data = image.encoded(as: renderType) else { throw SaveActivityError.failedImageEncode }

                    try data.write(to: renderedContentURL)

                    try await PHPhotoLibrary.shared().performChanges {
                        let changeRequest = PHAssetChangeRequest(for: asset)
                        changeRequest.contentEditingOutput = output
                        print("Change request created with contentEditingOutput: \(output)")
                    }

                    print("Changes successfully committed to the photo library.")
                    self?.activityDidFinish(true)
                } catch {
                    ErrorHandler().log(error)
                    print("Error during performChanges: \(error)")
                    self?.activityDidFinish(false)
                }
            }
        }
    }
}

extension PHContentEditingOutput {
    var renderingInformation: (URL, UTType) {
        guard #available(iOS 17, *),
              let type = defaultRenderedContentType,
              let typeURL = try? renderedContentURL(for: type)
        else { return (renderedContentURL, .jpeg) }

        return (typeURL, type)
    }
}
