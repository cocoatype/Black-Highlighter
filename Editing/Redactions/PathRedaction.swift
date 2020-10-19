//  Created by Geoff Pado on 5/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct PathRedaction: Redaction {
    init(_ path: UIBezierPath) {
        self.paths = [path]
    }

    let paths: [UIBezierPath]
}