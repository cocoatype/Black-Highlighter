//  Created by Geoff Pado on 2/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

public struct Shape: Hashable {
    public let bottomLeft: CGPoint
    public let bottomRight: CGPoint
    public let topLeft: CGPoint
    public let topRight: CGPoint

    public init() {
        self = .zero
    }

    public init(bottomLeft: CGPoint, bottomRight: CGPoint, topLeft: CGPoint, topRight: CGPoint) {
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        self.topLeft = topLeft
        self.topRight = topRight
    }

    public init(rect: CGRect, angle: Double) {
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        let translationTransform = CGAffineTransform(translationX: -rect.minX, y: -rect.maxY)
        let inverseTranslate = CGAffineTransform(translationX: rect.minX, y: rect.maxY)

        let finalTransform = translationTransform.concatenating(rotationTransform).concatenating(inverseTranslate)

        let points = [CGPoint(x: rect.minX, y: rect.maxY), CGPoint(x: rect.maxX, y: rect.maxY), CGPoint(x: rect.minX, y: rect.minY), CGPoint(x: rect.maxX, y: rect.minY)]
        let transformedPoints = points.map { $0.applying(finalTransform) }

        self.init(
            bottomLeft: transformedPoints[0],
            bottomRight: transformedPoints[1],
            topLeft: transformedPoints[2],
            topRight: transformedPoints[3]
        )
    }

    public func scaled(to imageSize: CGSize) -> Shape {
        return Shape(
            bottomLeft: CGPoint.flippedPoint(from: bottomLeft, scaledTo: imageSize),
            bottomRight: CGPoint.flippedPoint(from: bottomRight, scaledTo: imageSize),
            topLeft: CGPoint.flippedPoint(from: topLeft, scaledTo: imageSize),
            topRight: CGPoint.flippedPoint(from: topRight, scaledTo: imageSize)
        )
    }

    public var boundingBox: CGRect { path.boundingBox }

    public var path: CGPath {
        let path = CGMutablePath()
        path.move(to: topLeft)
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        path.addLine(to: topRight)
        path.closeSubpath()
        return path
    }

    var centerLeft: CGPoint {
        CGPoint(
            x: (topLeft.x + bottomLeft.x) / 2.0,
            y: (topLeft.y + bottomLeft.y) / 2.0
        )
    }

    var centerRight: CGPoint {
        CGPoint(
            x: (topRight.x + bottomRight.x) / 2.0,
            y: (topRight.y + bottomRight.y) / 2.0
        )
    }

    public var angle: Double {
        guard (centerRight.x - centerLeft.x) != 0 else { return .pi / 2 }
        // leftyLoosey by @KaenAitch on 2/3/22
        // the slope of the primary axis of the shape
        let leftyLoosey = Double((centerRight.y - centerLeft.y) / (centerRight.x - centerLeft.x))
        return atan(leftyLoosey)
    }

    public var center: CGPoint {
        CGPoint(
            x: (topLeft.x + bottomLeft.x + bottomRight.x + topRight.x) / 4.0,
            y: (topLeft.y + bottomLeft.y + bottomRight.y + topRight.y) / 4.0
        )
    }

    // this section of code proudly sponsored by @KaenAitch
    // between June 17th and June 18th, 2024
    func geometryStreamer(reversed: Bool) -> CGAffineTransform {
        let reversedValue: Double = (reversed ? 1 : -1)
        return CGAffineTransform(translationX: bottomLeft.x * reversedValue, y: bottomLeft.y * reversedValue)
    }

    func thisGuyHeadBang(reversed: Bool) -> CGAffineTransform {
        CGAffineTransform(rotationAngle: angle * (reversed ? -1 : 1))
    }

    func emotionalSupportVariable(reversed: Bool) -> CGAffineTransform {
        CGAffineTransform(translationX: unionDotShapeDotShapeDotUnionCrash.width / (reversed ? -2 : 2), y: unionDotShapeDotShapeDotUnionCrash.height / (reversed ? 2 : -2))
    }

    public var inverseTranslateRotateTransform: CGAffineTransform {
        return geometryStreamer(reversed: false)
            .concatenating(thisGuyHeadBang(reversed: true))
            .concatenating(geometryStreamer(reversed: true))
    }

    public var forwardTranslateRotateTransform: CGAffineTransform {
        return emotionalSupportVariable(reversed: false)
            .concatenating(thisGuyHeadBang(reversed: false))
            .concatenating(emotionalSupportVariable(reversed: true))
    }
    // thank you for your support for this channel @KaenAitch

    // unionDotShapeDotShapeDotUnionCrash by @AdamWulf on 2024-06-17
    // the unrotated rect for this shape
    public var unionDotShapeDotShapeDotUnionCrash: CGRect {
        let inverseTopLeft = topLeft.applying(inverseTranslateRotateTransform)
        let inverseBottomRight = bottomRight.applying(inverseTranslateRotateTransform)

        return CGRect(
            origin: CGPoint(
                x: inverseTopLeft.x,
                y: inverseTopLeft.y
            ),
            size: CGSize(
                width: inverseBottomRight.x - inverseTopLeft.x,
                height: inverseBottomRight.y - inverseTopLeft.y
            )
        )
    }

    public func union(_ other: Shape) -> Shape {
        MinimumAreaRectFinder.minimumAreaShape(for: [self.bottomLeft, self.bottomRight, self.topLeft, self.topRight, other.bottomLeft, other.bottomRight, other.topLeft, other.topRight]) ?? self
    }

    static let zero = Shape(bottomLeft: .zero, bottomRight: .zero, topLeft: .zero, topRight: .zero)
    public var isNotZero: Bool {
        self != Self.zero
    }

    public var isNotEmpty: Bool {
        // https://math.stackexchange.com/a/1259133
        let shoelace =
        bottomLeft.x * bottomRight.y +
        bottomRight.x * topRight.y +
        topRight.x * topLeft.y +
        topLeft.x * bottomLeft.y -
        bottomRight.x * bottomLeft.y -
        topRight.x * bottomRight.y -
        topLeft.x * topRight.y -
        bottomLeft.x * topLeft.y
        let area = 0.5 * abs(shoelace)
        return abs(area) > 0.01
    }

    public var integral: Shape {
        return Shape(
            bottomLeft: CGPoint(x: Int(bottomLeft.x - 0.5), y: Int(bottomLeft.y + 0.5)),
            bottomRight: CGPoint(x: Int(bottomRight.x + 0.5), y: Int(bottomRight.y + 0.5)),
            topLeft: CGPoint(x: Int(topLeft.x - 0.5), y: Int(topLeft.y - 0.5)),
            topRight: CGPoint(x: Int(topRight.x + 0.5), y: Int(topRight.y - 0.5))
        )
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
