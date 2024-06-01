//  Created by Geoff Pado on 5/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Detections

struct AutoRedactionsCategoryDefaultsMapper {
    private func defaults(for category: Category) -> Defaults.Value<Bool> {
        switch category {
        case .names:
            return Defaults.Value(key: .autoRedactionsCategoryNames)
        case .addresses:
            return Defaults.Value(key: .autoRedactionsCategoryAddresses)
        case .phoneNumbers:
            return Defaults.Value(key: .autoRedactionsCategoryPhoneNumbers)
        }
    }

    func value(for category: Category) -> Bool {
        defaults(for: category).wrappedValue
    }

    func set(_ value: Bool, for category: Category) {
        defaults(for: category).wrappedValue = value
    }
}
