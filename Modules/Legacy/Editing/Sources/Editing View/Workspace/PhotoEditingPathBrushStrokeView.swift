//  Created by Geoff Pado on 10/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

class PhotoEditingPathBrushStrokeView: UIControl, PhotoEditingBrushStrokeView {
    var color = UIColor.black {
        didSet { pathLayer?.strokeColor = color.cgColor }
    }
    private(set) var currentPath: UIBezierPath?

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        isOpaque = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    override class var layerClass: AnyClass { PathLayer.self }
    private var pathLayer: PathLayer? { layer as? PathLayer }

    private static var standardLineWidth = 10.0
    private var lineWidth = PhotoEditingPathBrushStrokeView.standardLineWidth {
        didSet { pathLayer?.lineWidth = lineWidth }
    }
    func updateTool(currentZoomScale: CGFloat) {
        lineWidth = Self.standardLineWidth * pow(currentZoomScale, -1.0)
    }

    // MARK: Touch Handling

    private var previousPoint: CGPoint?
    private var previousEndPoint: CGPoint?

    private func newPath() -> UIBezierPath {
        let newPath = UIBezierPath()
        newPath.lineCapStyle = .butt
        newPath.lineJoinStyle = .bevel
        newPath.lineWidth = lineWidth
        return newPath
    }

    private func clearPath() {
        currentPath = nil
        previousPoint = nil
        previousEndPoint = nil
        pathLayer?.path = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        currentPath = newPath()
        currentPath?.move(to: location)
        previousPoint = location

        pathLayer?.path = currentPath?.cgPath
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first,
              let path = currentPath,
              let previousPoint = previousPoint else { return }

        let currentPoint = touch.location(in: self)

        // Smooth the line by using quadratic curves
        let midPoint = CGPoint(
            x: (previousPoint.x + currentPoint.x) / 2,
            y: (previousPoint.y + currentPoint.y) / 2
        )

        if previousEndPoint != nil {
            path.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        } else {
            path.addLine(to: midPoint)
        }

        previousEndPoint = midPoint
        self.previousPoint = currentPoint

        // Update shape layer with the new path
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pathLayer?.path = path.cgPath
        CATransaction.commit()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        clearPath()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first,
              let path = currentPath else { return }

        let location = touch.location(in: self)
        path.addLine(to: location)
        pathLayer?.path = path.cgPath

        sendActions(for: .touchUpInside)
        clearPath()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    private class PathLayer: CAShapeLayer {
        override init() {
            super.init()
            fillColor = nil
            strokeColor = UIColor.black.cgColor
            lineCap = .butt
            lineJoin = .bevel
            lineWidth = PhotoEditingPathBrushStrokeView.standardLineWidth
        }

        override init(layer: Any) {
            super.init(layer: layer)
        }

        @available(*, unavailable)
        required init(coder: NSCoder) {
            let typeName = NSStringFromClass(type(of: self))
            fatalError("\(typeName) does not implement init(coder:)")
        }
    }
}
