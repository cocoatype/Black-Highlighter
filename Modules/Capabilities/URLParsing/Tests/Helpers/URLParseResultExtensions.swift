//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import URLParsing

extension URLParseResult {
    var isImage: Bool {
        switch self {
        case .image: true
        case .callbackAction, .website, .invalid: false
        }
    }

    var isInvalid: Bool {
        switch self {
        case .invalid: true
        case .callbackAction, .website, .image: false
        }
    }

    var isCallbackAction: Bool {
        switch self {
        case .callbackAction: true
        case .invalid, .website, .image: false
        }
    }

    var webURL: URL? {
        switch self {
        case .website(let webURL): webURL
        case .callbackAction, .image, .invalid: nil
        }
    }
}
