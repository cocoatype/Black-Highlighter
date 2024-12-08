//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos

@testable import Exporting

struct StubExportableAsset: ExportableAsset {
    func requestContentEditingInput(with options: PHContentEditingInputRequestOptions?) async -> (PHContentEditingInput?, [AnyHashable: Any]) {
        return (PHContentEditingInput(), [:])
    }

    var changeRequest: PHAssetChangeRequest {
        let asset = PHAsset()
        return PHAssetChangeRequest(for: asset)
    }
}
