//  Created by Geoff Pado on 10/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class PhotoEditingCanvasView: PKCanvasView {
    public var color: UIColor {
        didSet {
            guard let currentTool = tool as? PKInkingTool else { return }
            tool = PKInkingTool(currentTool.inkType, color: color, width: currentTool.width)
        }
    }

    init() {
        self.color = .black
        super.init(frame: .zero)
        accessibilityIgnoresInvertColors = true
        drawingPolicy = .anyInput
        backgroundColor = .clear
        isOpaque = false
        overrideUserInterfaceStyle = .light
        tool = tool(forZoomScale: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Tool Creations

    public var currentLineWidth: CGFloat {
        (tool as? PKInkingTool)?.width ?? 0
    }

    private func tool(forZoomScale zoomScale: CGFloat) -> PKTool {
        let lineWidth = adjustedLineWidth(forZoomScale: zoomScale)
        return PKInkingTool(.marker, color: color, width: lineWidth)
    }

    // MARK: Zoom Handling

    public func updateTool(currentZoomScale: CGFloat) {
        tool = tool(forZoomScale: currentZoomScale)
    }

    private static let standardLineWidth = 10.0
    private func adjustedLineWidth(forZoomScale zoomScale: CGFloat) -> CGFloat {
        Self.standardLineWidth * pow(zoomScale, -1.0)
    }

    // MARK: Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        brushStrokeView?.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        brushStrokeView?.touchesMoved(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        brushStrokeView?.touchesCancelled(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        brushStrokeView?.touchesEnded(touches, with: event)
    }

    // MARK: Boilerplate

    private var brushStrokeView: PhotoEditingCanvasBrushStrokeView? {
        superview as? PhotoEditingCanvasBrushStrokeView
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
