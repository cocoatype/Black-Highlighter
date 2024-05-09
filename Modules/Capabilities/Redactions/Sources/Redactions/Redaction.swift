//  Created by Geoff Pado on 5/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

public struct Redaction: Equatable {
    public let color: RedactionColor
    public let parts: [RedactionPart]

    public init(color: RedactionColor, parts: [RedactionPart]) {
        self.color = color
        self.parts = parts.filter { part in
            if case .shape(let shape) = part {
                return shape.isNotEmpty
            } else { return true }
        }
    }

    public var paths: [RedactionPath] {
        parts.map(\.path)
    }
}
