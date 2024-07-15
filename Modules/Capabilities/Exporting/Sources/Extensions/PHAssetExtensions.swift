//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos

extension PHAsset {
    var imageType: UTType? {
        let resources = PHAssetResource.assetResources(for: self)

        guard let resource = resources.first(where: { $0.type == .photo })
        else { return nil }

        return UTType(resource.uniformTypeIdentifier)
    }
}
