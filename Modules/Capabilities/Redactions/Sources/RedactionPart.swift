//  Created by Geoff Pado on 5/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Observations

public enum RedactionPart: Equatable {
    case path(RedactionPath)
    case shape(Shape)

    var path: RedactionPath {
        switch self {
        case .path(let path): return path
        case .shape(let shape): return RedactionPath(cgPath: shape.path)
        }
    }
}