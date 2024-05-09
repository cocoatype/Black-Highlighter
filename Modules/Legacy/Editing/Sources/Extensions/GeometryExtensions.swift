//  Created by Geoff Pado on 4/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CoreGraphics

public extension CGSize {
    static func * (size: CGSize, multiplier: CGFloat) -> CGSize {
        return CGSize(width: size.width * multiplier, height: size.height * multiplier)
    }

    var integral: CGSize {
        CGSize(width: floor(width), height: floor(height))
    }
}

public extension CGPoint {
    static func * (point: CGPoint, multiplier: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * multiplier, y: point.y * multiplier)
    }

    static func + (point: CGPoint, size: CGSize) -> CGPoint {
        return CGPoint(x: point.x + size.width, y: point.y + size.height)
    }

    func isEqual(to otherPoint: CGPoint, accuracy: Double) -> Bool {
        return (abs(x - otherPoint.x) < accuracy) && (abs(y - otherPoint.y) < accuracy)
    }

    func distance(to otherPoint: CGPoint) -> Double {
        func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
            return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
        }

        func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
            return sqrt(CGPointDistanceSquared(from: from, to: to))
        }

        return CGPointDistance(from: self, to: otherPoint)
    }
}

public extension CGRect {
    static func * (rect: CGRect, multiplier: CGFloat) -> CGRect {
        return CGRect(x: rect.origin.x * multiplier, y: rect.origin.y * multiplier, width: rect.size.width * multiplier, height: rect.size.height * multiplier)
    }

    init(_ pointA: CGPoint, _ pointB: CGPoint) {
        let width = pointB.x - pointA.x
        let height = pointB.y - pointA.y
        let nonstandardRect = CGRect(origin: pointA, size: CGSize(width: width, height: height))
        let standardRect = nonstandardRect.standardized
        self.init(origin: standardRect.origin, size: standardRect.size)
    }

    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    func fitting(rect fittingRect: CGRect) -> CGRect {
        let aspectRatio = width / height
        let fittingAspectRatio = fittingRect.width / fittingRect.height

        if fittingAspectRatio > aspectRatio { // wider fitting rect
            let newRectWidth = aspectRatio * fittingRect.height
            let newRectHeight = fittingRect.height
            let newRectX = (fittingRect.width - newRectWidth) / 2
            let newRectY = CGFloat(0)

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)
        } else if fittingAspectRatio < aspectRatio { // taller fitting rect
            let newRectWidth = fittingRect.width
            let newRectHeight = 1 / (aspectRatio / fittingRect.width)
            let newRectX = CGFloat(0)
            let newRectY = (fittingRect.height - newRectHeight) / 2

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)

        } else { // same aspect ratio
            return fittingRect
        }
    }

    static func flippedRect(from rect: CGRect, scaledTo size: CGSize) -> CGRect {
        var scaledRect = rect

        #if canImport(UIKit)
        scaledRect.origin.y = (1.0 - scaledRect.origin.y)
        #endif

        scaledRect.origin.x *= size.width
        scaledRect.origin.y *= size.height
        scaledRect.size.width *= size.width
        scaledRect.size.height *= size.height

        #if canImport(UIKit)
        scaledRect.origin.y -= scaledRect.size.height
        #endif

        return scaledRect.integral
    }
}
