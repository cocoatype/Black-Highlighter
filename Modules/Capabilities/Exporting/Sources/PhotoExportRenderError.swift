//  Created by Geoff Pado on 6/21/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

public enum PhotoExportRenderError: Error {
    case noCurrentGraphicsContext
    case noCGImage
    case noResultImage
}
