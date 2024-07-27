//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Redactions
import UIKit

public enum SceneDependencies {
    case image(UIImage, [Redaction]?)
    case url(URL, [Redaction]?)
    case imageAndURL(UIImage, URL, [Redaction]?)

    init?(image: UIImage?, url: URL?, redactions: [Redaction]?) {
        switch (image, url) {
        case (.some(let image), .some(let url)):
            self = .imageAndURL(image, url, redactions)
        case (.none, .some(let url)):
            self = .url(url, redactions)
        case (.some(let image), .none):
            self = .image(image, redactions)
        case (.none, .none):
            return nil
        }
    }

    public var image: UIImage? {
        switch self {
        case .image(let image, _), .imageAndURL(let image, _, _): image
        case .url: nil
        }
    }

    public var representedURL: URL? {
        switch self {
        case .url(let url, _), .imageAndURL(_, let url, _): url
        case .image: nil
        }
    }

    public var redactions: [Redaction]? {
        switch self {
        case .image(_, let redactions),
                .url(_, let redactions),
                .imageAndURL(_, _, let redactions):
            redactions
        }
    }
}
