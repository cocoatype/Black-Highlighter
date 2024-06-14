//  Created by Geoff Pado on 5/3/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

@available(iOS 16.0, *)
enum ShortcutsRedactorError: Error, CustomLocalizedStringResourceConvertible {
    case exportFailed
    case noImage(Data)
    case unpurchased

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .exportFailed:
            LocalizedStringResource("ShortcutsRedactorError.exportFailed.localizedStringResource", bundle: .forClass(ShortcutRedactor.self))
        case .noImage(let data):
            LocalizedStringResource("ShortcutsRedactorError.noImage.localizedStringResource\(data.map { String(format: "%02x", $0) }.joined())", bundle: .forClass(ShortcutRedactor.self))
        case .unpurchased:
            LocalizedStringResource("ShortcutsRedactorError.unpurchased.localizedStringResource", bundle: .forClass(ShortcutRedactor.self))
        }
    }
}
