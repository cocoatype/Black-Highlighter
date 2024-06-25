//  Created by Geoff Pado on 5/1/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import UIKit

public protocol FileURLProvider {
    var representedFileURL: URL? { get }
    func updateRepresentedFileURL(to newURL: URL)
}

extension FileURLProvider {
    var representedFileName: String? { representedFileURL?.lastPathComponent }
}

public extension UIResponder {
    var fileURLProvider: FileURLProvider? {
        if let provider = (self as? FileURLProvider) {
            return provider
        }

        return next?.fileURLProvider
    }
}
