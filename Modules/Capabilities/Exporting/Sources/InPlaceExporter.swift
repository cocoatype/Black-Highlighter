//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Foundation
import Photos
import Redactions
import UIKit

public class InPlaceExporter: NSObject {
    private let preparedURL: URL
    private let asset: PHAsset
    private let redactions: [Redaction]

    public init(preparedURL: URL, asset: PHAsset, redactions: [Redaction]) {
        self.preparedURL = preparedURL
        self.asset = asset
        self.redactions = redactions
    }

    public func export() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            asset.requestContentEditingInput(with: nil) { [weak self] contentEditingInput, _ in
                Task { [weak self] in
                    do {
                        guard let self,
                              let input = contentEditingInput
                        else { throw ExportingError.noInputProvided }

                        let factory = OutputFactory(preparedURL: preparedURL, redactions: redactions)
                        let output = try factory.output(from: input)

                        try await PHPhotoLibrary.shared().performChanges { [asset] in
                            let changeRequest = PHAssetChangeRequest(for: asset)
                            changeRequest.contentEditingOutput = output
                            print("Change request created with contentEditingOutput: \(output)")
                        }

                        print("Changes successfully committed to the photo library.")
                        continuation.resume()
                    } catch {
                        ErrorHandler().log(error)
                        print("Error during performChanges: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
