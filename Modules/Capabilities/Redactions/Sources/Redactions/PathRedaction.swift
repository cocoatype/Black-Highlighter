//  Created by Geoff Pado on 5/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if canImport(UIKit)
import UIKit

extension Redaction {
    public init(path: UIBezierPath, color: UIColor) {
        self.init(color: color, parts: [.path(path)])
    }
}
#endif
