//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos
import Redactions
import UIKit

public class OutputFactory {
    private let preparedURL: URL
    private let redactions: [Redaction]

    public init(preparedURL: URL, redactions: [Redaction]) {
        self.preparedURL = preparedURL
        self.redactions = redactions
    }

    public func output(from input: PHContentEditingInput) throws -> PHContentEditingOutput {
        let output = PHContentEditingOutput(contentEditingInput: input)
        guard let formatVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { throw ExportingError.missingBundleVersion }
        let data = try JSONEncoder().encode(SaveActivityAdjustmentData(redactions: redactions))
        output.adjustmentData = PHAdjustmentData(formatIdentifier: SaveActivityAdjustmentData.formatIdentifier, formatVersion: formatVersion, data: data)
        let (renderedContentURL, renderType) = output.renderingInformation

        guard let image = UIImage(contentsOfFile: preparedURL.path) else { throw ExportingError.failedImageDecode }
        guard let data = image.encoded(as: renderType) else { throw ExportingError.failedImageEncode }

        try data.write(to: renderedContentURL)
        return output
    }
}
