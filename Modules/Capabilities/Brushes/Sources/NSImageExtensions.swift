//  Created by Geoff Pado on 6/21/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSImage {
    var cgImage: CGImage? {
        cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
}
#endif
