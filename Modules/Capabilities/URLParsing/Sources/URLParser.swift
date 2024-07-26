//  Created by Geoff Pado on 7/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

public struct URLParser {
    public init() {}

    public func parse(_ url: URL) -> URLParseResult {
        if let action = CallbackAction(url: url) {
            return .callbackAction(action)
        } else if let image = loadImage(at: url) {
            return .image(image)
        } else {
            return .invalid
        }
    }

    func loadImage(at url: URL) -> UIImage? {
        guard let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData)
        else { return nil }

        return image
    }
}
