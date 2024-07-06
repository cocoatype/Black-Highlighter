//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

enum SaveActivityError: Error {
    case missingBundleVersion
    case noActivityURL
    case noInputProvided
    case failedImageDecode
    case failedImageEncode
    case unexpectedHEIC
    case unexpectedEncodeType(String)
}