//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import URLParsing

extension URLParseResult {
    var imageURL: URL? {
        switch self {
        case .image(let imageURL): imageURL
        case .callbackAction, .website, .invalid: nil
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
