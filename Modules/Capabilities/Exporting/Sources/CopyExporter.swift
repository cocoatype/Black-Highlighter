//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Photos
import Redactions

public class CopyExporter: NSObject {
    private let preparedURL: URL

    public init(preparedURL: URL) {
        self.preparedURL = preparedURL
    }

    public func export() async throws {
        try await PHPhotoLibrary.shared().performChanges { [preparedURL] in
            PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: preparedURL)
        }
    }
}
