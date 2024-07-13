//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Photos
import UniformTypeIdentifiers

extension PHContentEditingOutput {
    var renderingInformation: (URL, UTType) {
        guard #available(iOS 17, *),
              let type = defaultRenderedContentType,
              let typeURL = try? renderedContentURL(for: type)
        else { return (renderedContentURL, .jpeg) }

        return (typeURL, type)
    }
}
