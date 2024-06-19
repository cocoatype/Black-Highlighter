//  Created by Geoff Pado on 6/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

public enum MinimumAreaShapeFinder {
    public static func minimumAreaShape(for shapes: [Shape]) -> Shape {
        minimumAreaShape(for: shapes.flatMap(\.inverseTranslateRotateTransform))
    }

    private static func minimumAreaShape(for points: [CGPoint]) -> Shape {
        var minArea = CGFloat.greatestFiniteMagnitude
        var bestShape = Shape.zero

        for i in 0..<points.count {
            for j in i+1..<points.count {
                let p1 = points[i]
                let p2 = points[j]
                let angle = atan2(p2.y - p1.y, p2.x - p1.x)
                let rotatedPoints = points.map { rotate(point: $0, around: p1, by: -angle) }
                let rect = boundingRect(for: rotatedPoints)
                let area = rect.width * rect.height
                if area < minArea {
                    minArea = area
                    bestShape = Shape(
                        bottomLeft: rotate(point: CGPoint(x: rect.minX, y: rect.maxY), around: p1, by: angle),
                        bottomRight: rotate(point: CGPoint(x: rect.maxX, y: rect.maxY), around: p1, by: angle),
                        topLeft: rotate(point: CGPoint(x: rect.minX, y: rect.minY), around: p1, by: angle),
                        topRight: rotate(point: CGPoint(x: rect.maxX, y: rect.minY), around: p1, by: angle)
                    )
                }
            }
        }

        return bestShape
    }

    private static func rotate(point: CGPoint, around origin: CGPoint, by angle: CGFloat) -> CGPoint {
        let translatedX = point.x - origin.x
        let translatedY = point.y - origin.y
        let rotatedX = translatedX * cos(angle) - translatedY * sin(angle)
        let rotatedY = translatedX * sin(angle) + translatedY * cos(angle)
        return CGPoint(x: rotatedX + origin.x, y: rotatedY + origin.y)
    }

    private static func boundingRect(for points: [CGPoint]) -> CGRect {
        let minX = points.map { $0.x }.min() ?? 0
        let maxX = points.map { $0.x }.max() ?? 0
        let minY = points.map { $0.y }.min() ?? 0
        let maxY = points.map { $0.y }.max() ?? 0
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
