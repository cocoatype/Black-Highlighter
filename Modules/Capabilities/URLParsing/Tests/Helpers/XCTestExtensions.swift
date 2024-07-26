//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import XCTest

extension XCTestCase {
    var imageURL: URL {
        get throws {
            try XCTUnwrap(Bundle.module.url(forResource: "Sample", withExtension: "png"))
        }
    }
}
