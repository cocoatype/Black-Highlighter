//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos

protocol ExportableAsset {
    func requestContentEditingInput(with options: PHContentEditingInputRequestOptions?) async -> (PHContentEditingInput?, [AnyHashable: Any])

    var changeRequest: PHAssetChangeRequest { get }
}

extension PHAsset: ExportableAsset {
    public func requestContentEditingInput(with options: PHContentEditingInputRequestOptions?) async -> (PHContentEditingInput?, [AnyHashable: Any]) {
        await withCheckedContinuation { continuation in
            requestContentEditingInput(with: options) { input, info in
                continuation.resume(returning: (input, info))
            }
        }
    }

    public var changeRequest: PHAssetChangeRequest {
        PHAssetChangeRequest(for: self)
    }
}

enum ExportableAssetError: Error {
    case unexpectedNil
}
