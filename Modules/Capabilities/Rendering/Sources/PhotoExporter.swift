//  Created by Geoff Pado on 5/13/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import RedactionsMac
#elseif canImport(UIKit)
import Redactions
import UIKit

public class PhotoExporter: NSObject {
    public static func export(_ image: UIImage, redactions: [Redaction]) async throws -> UIImage {
        return try await PhotoExportRenderer(image: image, redactions: redactions).render()
    }
}
#endif
