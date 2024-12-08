//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Foundation
import Logging
import Photos
import Redactions

public class CopyExporter: NSObject {
    private let preparedURL: URL
    public convenience init(preparedURL: URL) {
        self.init(preparedURL: preparedURL, logger: Logging.logger, library: PHPhotoLibrary.shared())
    }

    private let logger: any Logger
    private let library: any PhotoLibrary
    init(
        preparedURL: URL,
        logger: any Logger,
        library: any PhotoLibrary
    ) {
        self.preparedURL = preparedURL
        self.logger = logger
        self.library = library
    }

    public func export() async throws {
        try await library.performChanges { [preparedURL] in
            PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: preparedURL)
        }

        Defaults.numberOfSaves = Defaults.numberOfSaves + 1
        logger.log(ExportingEventFactory().event(style: .copy))
    }
}
