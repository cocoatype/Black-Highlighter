//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

public struct PencilMenu: View {
    static let outerDiameter: Double = 298
    static let padding: Double = 8

    static var outerCircumference: Double {
        return Double.pi * PencilMenu.outerDiameter
    }

    private static let regularScale = CGSize(dimension: 1.0)
    private static let expandedScale = CGSize(dimension: 1.4)

    private let isMenuShowing: Bool
    private let menuPosition: CGPoint
    private let hoverPosition: CGPoint?
    @Binding private var selectedTool: HighlighterTool?
    private let toolSelectionHandler: (HighlighterTool) -> Void
    public init(
        isMenuShowing: Bool,
        menuPosition: CGPoint,
        hoverPosition: CGPoint?,
        selectedTool: Binding<HighlighterTool?>,
        toolSelectionHandler: @escaping (HighlighterTool) -> Void
    ) {
        self.isMenuShowing = isMenuShowing
        self.menuPosition = menuPosition
        self.hoverPosition = hoverPosition
        _selectedTool = selectedTool
        self.toolSelectionHandler = toolSelectionHandler
    }

    public var body: some View {
        ZStack {
            PencilMenuBackground()
            ForEach(Self.indexedTools, id: \.0) { (tool, index) in
                PencilMenuItem(tool: tool) {
                    toolSelectionHandler(tool)
                }
                .scaleEffect(selectedTool == tool ? Self.expandedScale : Self.regularScale)
                .transformEffect(itemTransform(index: index))
                .animation(.easeInOut(duration: 0.1), value: selectedTool)
            }
        }
        .onChange(of: hoverPosition) { _ in
            let selectedIndexedTool = Self.indexedTools.first(where: { (_, index) in
                guard let adjustedPosition else { return false }
                return path(at: index).contains(adjustedPosition)
            })
            selectedTool = selectedIndexedTool?.0
        }
        .scaleEffect(isMenuShowing ? 1.0 : 0.5)
        .opacity(isMenuShowing ? 1 : 0)
        .animation(.bouncy(duration: 0.3, extraBounce: 0.1), value: isMenuShowing)
        .disabled(isMenuShowing == false)
        .position(menuPosition)
    }

    private var adjustedPosition: CGPoint? {
        guard let hoverPosition else { return nil }
        let menuOrigin = CGPoint(
            x: menuPosition.x - (Self.outerDiameter / 2),
            y: menuPosition.y - (Self.outerDiameter / 2)
        )

        return CGPoint(
            x: hoverPosition.x - menuOrigin.x,
            y: hoverPosition.y - menuOrigin.y)
    }

    private func path(at index: Int) -> Path {
        let buttonRect = CGRect(origin: .zero, size: CGSize(dimension: PencilMenuItem.diameter))
        return Path(ellipseIn: buttonRect)
            .applying(itemTransform(index: index))
            .applying(CGAffineTransform(translationX: (Self.outerDiameter - PencilMenuItem.diameter) / 2, y: (Self.outerDiameter - PencilMenuItem.diameter) / 2))
    }

    private static let indexedTools: [(HighlighterTool, Int)] = {
        zip(HighlighterTool.allCases, HighlighterTool.allCases.indices)
            .map { $0 }
    }()

    private func itemTransform(index: Int) -> CGAffineTransform {
        let offset = (Self.padding + PencilMenuItem.diameter) * index
        let offsetPercent = offset / Self.outerCircumference
        let rotation = offsetPercent * (Double.pi * 2)

        let translateTransform = CGAffineTransform(translationX: Self.outerDiameter / 2, y: 0)
        let centerOffsetTransform = CGAffineTransform(translationX: PencilMenuItem.diameter / -2, y: PencilMenuItem.diameter / -2)
        let rotateTransform = CGAffineTransform(rotationAngle: rotation)
        let centerResetTransform = CGAffineTransform(translationX: PencilMenuItem.diameter / 2, y: PencilMenuItem.diameter / 2)
        return translateTransform
            .concatenating(centerOffsetTransform)
            .concatenating(rotateTransform)
            .concatenating(centerResetTransform)
    }
}

struct PositionModifier: ViewModifier {
    let menuPosition: CGPoint

    func body(content: Content) -> some View {
        content.position(menuPosition)
            .animation(nil)
    }
}

@available(iOS 15.0, *)
enum PencilMenuPreviews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var isMenuShowing = false
        var body: some View {
            ZStack {
                Button {
                    withAnimation {
                        isMenuShowing.toggle()
                    }
                } label: {
                    Text("Toggle Menu \(isMenuShowing)")
                }
                PencilMenu(isMenuShowing: isMenuShowing, menuPosition: .zero, hoverPosition: nil, selectedTool: .constant(nil)) { _ in }
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
