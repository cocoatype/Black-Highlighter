//  Created by Geoff Pado on 7/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

enum DesktopSaveError: Error {
    case missingRepresentedURL
    case missingImageType
    case noImageData

    var alertTitle: String {
        switch self {
        case .missingRepresentedURL: return CoreStrings.DesktopSaveError.missingRepresentedURLTitle
        case .missingImageType: return CoreStrings.DesktopSaveError.missingImageTypeTitle
        case .noImageData: return CoreStrings.DesktopSaveError.noImageDataTitle
        }
    }

    var alertMessage: String {
        return CoreStrings.DesktopSaveError.alertMessage
    }
}
