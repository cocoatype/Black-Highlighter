//  Created by Geoff Pado on 6/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Observations

@available(iOS 16.0, *)
struct PhotoEditingSystemIntersectionFinder: PhotoEditingIntersectionFinder {
    func intersectionExists(between lhs: CGPath, and rhs: CGPath) -> Bool {
        lhs.intersects(rhs) || rhs.intersects(lhs)
    }
}
