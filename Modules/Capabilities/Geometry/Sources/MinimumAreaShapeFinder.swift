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

//    enum Orientation {
//        case collinear
//        case clockwise
//        case counterClockwise
//    }
//
//    private static func orientation(_ p: CGPoint, _ q: CGPoint, _ r: CGPoint) -> Orientation {
//        let val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
//        if val == 0 { return .collinear }
//        return (val > 0) ? .clockwise : .counterClockwise
//    }
//
//    // Helper function to find the square of the distance between two points
//    private static func distanceSquared(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
//        return (p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y)
//    }
//
//    // Function to find the convex hull using Graham Scan algorithm
//    static func convexHull(for points: [CGPoint]) -> [CGPoint] {
//        guard points.count >= 3 else { return points }
//
//        // Find the point with the lowest y-coordinate, break ties by x-coordinate
//        var minYPoint = points[0]
//        var minYIndex = 0
//        for (index, point) in points.enumerated() {
//            if (point.y < minYPoint.y) || (point.y == minYPoint.y && point.x < minYPoint.x) {
//                minYPoint = point
//                minYIndex = index
//            }
//        }
//
//        // Place the bottom-most point at the first position
//        var sortedPoints = points
//        sortedPoints.swapAt(0, minYIndex)
//
//        // Sort the remaining points based on the polar angle with the first point
//        let p0 = sortedPoints[0]
//        sortedPoints = sortedPoints.sorted { (p1, p2) -> Bool in
//            let o = orientation(p0, p1, p2)
//            if o == .collinear {
//                return distanceSquared(p0, p1) < distanceSquared(p0, p2)
//            }
//            return o == .counterClockwise
//        }
//
//        // Create an empty stack and push the first three points to it
//        var stack: [CGPoint] = [sortedPoints[0], sortedPoints[1], sortedPoints[2]]
//
//        // Process the remaining points
//        for i in 3..<sortedPoints.count {
//            while stack.count > 1 && orientation(stack[stack.count - 2], stack.last!, sortedPoints[i]) != .counterClockwise {
//                stack.removeLast()
//            }
//            stack.append(sortedPoints[i])
//        }
//
//        return stack
//    }
}
