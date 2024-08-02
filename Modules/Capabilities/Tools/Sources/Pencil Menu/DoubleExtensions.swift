//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

extension Double {
    static func * (lhs: Double, rhs: Int) -> Double {
        return lhs * Double(rhs)
    }

    static func * (lhs: Int, rhs: Double) -> Double {
        return Double(lhs) * rhs
    }
}
