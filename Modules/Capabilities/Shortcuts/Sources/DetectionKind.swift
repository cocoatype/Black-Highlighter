//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Detections

enum DetectionKind {
    case names
    case addresses
    case phoneNumbers

    var taggingFunction: ((String) -> [Substring]) {
        switch self {
        case .addresses: return StringTagger.detectAddresses(in:)
        case .names: return StringTagger.detectNames(in:)
        case .phoneNumbers: return StringTagger.detectPhoneNumbers(in:)
        }
    }
}
