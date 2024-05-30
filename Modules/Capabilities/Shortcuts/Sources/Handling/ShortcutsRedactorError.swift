//  Created by Geoff Pado on 5/3/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

@available(iOS 16.0, *)
enum ShortcutsRedactorError: Error, CustomLocalizedStringResourceConvertible {
    case noImage
    case unpurchased

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .noImage:
            LocalizedStringResource("ShortcutsRedactorError.noImage.localizedStringResource", bundle: .forClass(ShortcutRedactor.self))
        case .unpurchased:
            LocalizedStringResource("ShortcutsRedactorError.unpurchased.localizedStringResource", bundle: .forClass(ShortcutRedactor.self))
        }
    }
}
