//  Created by Geoff Pado on 10/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class PhotoEditingCanvasBrushStrokeView: UIControl, PhotoEditingBrushStrokeView, PKCanvasViewDelegate {
    var currentPath: UIBezierPath? = nil

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        canvasView.delegate = self
        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    var color: UIColor {
        get { canvasView.color }
        set { canvasView.color = newValue }
    }

    func updateTool(currentZoomScale: CGFloat) {
        canvasView.updateTool(currentZoomScale: currentZoomScale)
    }

    // MARK: Undo/Redo

    override var undoManager: UndoManager? { nil }

    // MARK: PKCanvasViewDelegate

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        guard canvasViewIsResetting == false else { return }

        currentPath = path(from: canvasView.drawing)

        sendActions(for: .touchUpInside)

        canvasViewIsResetting = true
        canvasView.drawing = PKDrawing()
        canvasViewIsResetting = false
    }

    // MARK: Path Manipulation

    private func newPath() -> UIBezierPath {
        let newPath = UIBezierPath()
        newPath.lineCapStyle = .round
        newPath.lineJoinStyle = .round
        newPath.lineWidth = canvasView.currentLineWidth
        return newPath
    }

    private func path(from drawing: PKDrawing) -> UIBezierPath {
        let bezierPath = newPath()
        if let strokePath = drawing.strokes.last?.path {
            bezierPath.move(to: strokePath.interpolatedLocation(at: 0))
            for i in (1..<strokePath.count) {
                bezierPath.addLine(to: strokePath.interpolatedLocation(at: CGFloat(i)))
            }
        }

        return bezierPath
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    private let canvasView = PhotoEditingCanvasView()
    private var canvasViewIsResetting = false
}

