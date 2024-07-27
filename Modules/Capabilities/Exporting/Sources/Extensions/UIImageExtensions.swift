//  Created by Geoff Pado on 7/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import UIKit
import UniformTypeIdentifiers

extension UIImage {
    var imageType: UTType? {
        guard let imageTypeString = cgImage?.utType
        else { return nil }

        return UTType(imageTypeString as String)
    }

    func encoded(as type: UTType) -> Data? {
        switch type {
        case .jpeg: return jpegData(compressionQuality: 0.75)
        case .heic:
            if #available(iOS 17, *) {
                return heicData()
            } else {
                ErrorHandler().log(ExportingError.unexpectedHEIC)
                return jpegData(compressionQuality: 0.75)
            }
        default:
            ErrorHandler().log(ExportingError.unexpectedEncodeType(type.identifier))
            return jpegData(compressionQuality: 0.75)
        }
    }
}
