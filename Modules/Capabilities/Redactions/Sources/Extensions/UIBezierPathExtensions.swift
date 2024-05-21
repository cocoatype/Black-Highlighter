//  Created by Geoff Pado on 5/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(UIKit)
import Geometry
import SwiftUI
import UIKit

extension UIBezierPath {
    var shape: Geometry.Shape? {
        let path = Path(self.cgPath)
        var elements = [Path.Element]()
        path.forEach { element in
            elements.append(element)
        }

        let points = elements.compactMap(\.point)

        return Shape(
            bottomLeft: points[1],
            bottomRight: points[2],
            topLeft: points[0],
            topRight: points[3]
        )
    }
}

private extension Path.Element {
    var point: CGPoint? {
        switch self {
        case .move(let to): return to
        case .line(let to): return to
        case .quadCurve: return nil
        case .curve: return nil
        case .closeSubpath: return nil
        }
    }
}
#endif
