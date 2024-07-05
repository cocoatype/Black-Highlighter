//  Created by Geoff Pado on 7/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Foundation

extension URL {
    init(websitePath: StaticString) {
        self = URL.websiteBaseURL.appendingPathComponent(String(websitePath))
    }

    init(staticString: StaticString) {
        guard let url = URL(string: String(staticString)) else { ErrorHandler().crash("Error creating URL from StaticString: \(staticString)") }
        self = url
    }

    private static let websiteBaseURL = URL(staticString: "https://blackhighlighter.app/")

    public static func url(forPath path: String) -> URL {
        URL.websiteBaseURL.appendingPathComponent(path)
    }
}

extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}
