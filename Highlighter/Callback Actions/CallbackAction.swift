//  Created by Geoff Pado on 5/29/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum CallbackAction {
    case edit(UIImage), open(UIImage)

    var image: UIImage {
        switch self {
        case .edit(let image): return image
        case .open(let image): return image
        }
    }

    init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let host = components.host,
            host == "x-callback-url",
            let queryItems = components.queryItems,
            let imageDataItem = queryItems.first(where: { $0.name == "imageData" }),
            let imageDataString = imageDataItem.value,
            let imageData = Data(base64Encoded: imageDataString),
            let image = UIImage(data: imageData)
            else { return nil }

        if url.path == "/edit" {
            self = .edit(image)
        } else if url.path == "/open" {
            self = .open(image)
        } else {
            return nil
        }
    }
}
