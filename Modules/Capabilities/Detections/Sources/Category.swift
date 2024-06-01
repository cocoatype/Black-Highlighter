//  Created by Geoff Pado on 5/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

public enum Category: CaseIterable {
    case names
    case addresses
    case phoneNumbers

    // getFuncyInSwizzleTown by @mono_nz on 2024-05-31
    // the tagging function for this category
    public var getFuncyInSwizzleTown: (String) -> [Substring] {
        switch self {
        case .addresses: return StringTagger.detectAddresses(in:)
        case .names: return StringTagger.detectNames(in:)
        case .phoneNumbers: return StringTagger.detectPhoneNumbers(in:)
        }
    }
}
