//  Created by Geoff Pado on 11/6/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Editing
import Exporting
import Intents
import OSLog
import Redactions
import UniformTypeIdentifiers

class ShortcutsRedactExporter: NSObject {
    func export(_ input: INFile, redactions: [Redaction]) async throws -> INFile {
        os_log("starting export with redactions: %{public}@", String(describing: redactions))
        guard let sourceImage = UIImage(data: input.data)
        else { throw ShortcutsExportError.noImageForInput }

        os_log("got source image")

        let exportImage = try await PhotoExportRenderer(image: sourceImage, redactions: redactions).render()

        os_log("got export image")

        guard let imageData = exportImage.pngData()
        else { throw ShortcutsExportError.failedToRenderImage }

        os_log("got rendered image data")

        let filename = ((input.filename as NSString).deletingPathExtension as NSString).appendingPathExtension(for: UTType.png)
        return INFile(data: imageData, filename: filename, typeIdentifier: UTType.png.identifier)
    }
}

enum ShortcutsExportError: Error {
    case failedToRenderImage
    case noImageForInput
}
