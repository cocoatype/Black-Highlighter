//  Created by Geoff Pado on 5/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import ObservationsNative

extension NSBezierPath {
    convenience init(cgPath: CGPath) {
        self.init()

        cgPath.applyWithBlock { elementPointer in
            let element = elementPointer.pointee

            switch element.type {
            case .moveToPoint:
                let point = element.points.pointee
                self.move(to: point)
            case .addLineToPoint:
                let point = element.points.pointee
                self.line(to: point)
            case .addQuadCurveToPoint:
                break // NSBezierPath does not support
            case .addCurveToPoint:
                let bufferPointer = UnsafeBufferPointer(start: element.points, count: 3)
                let points = Array(bufferPointer)
                self.curve(to: points[0], controlPoint1: points[1], controlPoint2: points[2])
            case .closeSubpath:
                self.close()
            @unknown default:
                break
            }
        }
    }
}

#endif
