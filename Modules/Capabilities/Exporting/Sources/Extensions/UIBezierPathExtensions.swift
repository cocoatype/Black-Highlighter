//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIBezierPath {
    public var dashedPath: UIBezierPath {
        let cgPath = self.cgPath
        let dashedCGPath = cgPath.copy(dashingWithPhase: 0, lengths: [4, 4])
        let dashedPath = UIBezierPath(cgPath: dashedCGPath)
        dashedPath.lineWidth = lineWidth
        return dashedPath
    }

    public func forEachPoint(_ function: @escaping ((CGPoint) -> Void)) {
        cgPath.forEachPoint(function)
    }
}
