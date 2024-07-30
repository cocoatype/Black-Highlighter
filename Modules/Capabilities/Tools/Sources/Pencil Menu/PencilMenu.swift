//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

@available(iOS 15.0, *)
public struct PencilMenu: View {
    static let outerDiameter: Double = 298
    static let padding: Double = 8

    static var outerCircumference: Double {
        return Double.pi * PencilMenu.outerDiameter
    }

    private let isMenuShowing: Bool
    private let menuPosition: CGPoint
    private let hoverPosition: CGPoint?
    public init(isMenuShowing: Bool, menuPosition: CGPoint, hoverPosition: CGPoint?) {
        self.isMenuShowing = isMenuShowing
        self.menuPosition = menuPosition
        self.hoverPosition = hoverPosition
    }

    public var body: some View {
        ZStack {
            PencilMenuBackground()
            ForEach(Self.indexedTools, id: \.0) { (tool, index) in
                PencilMenuItem(tool: tool)
                    .scaleEffect(scale(at: index))
                    .transformEffect(itemTransform(index: index, isOffset: true))
                    .animation(.easeInOut(duration: 0.1), value: scale(at: index))
            }
        }
        .scaleEffect(isMenuShowing ? 1.0 : 0.5)
        .opacity(isMenuShowing ? 1 : 0)
        .animation(.bouncy(duration: 0.3, extraBounce: 0.1), value: isMenuShowing)
        .disabled(isMenuShowing == false)
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
            .applying(itemTransform(index: index, isOffset: false))
            .applying(CGAffineTransform(translationX: (Self.outerDiameter - PencilMenuItem.diameter) / 2, y: (Self.outerDiameter - PencilMenuItem.diameter) / 2))
    }

    private func scale(at index: Int) -> CGSize {
        let regularScale = CGSize(dimension: 1.0)
        let expandedScale = CGSize(dimension: 1.4)
        guard let adjustedPosition else { return regularScale }
        let shouldScale = path(at: index).contains(adjustedPosition)

        return shouldScale ? expandedScale : regularScale
    }

    private static let indexedTools: [(HighlighterTool, Int)] = {
        zip(HighlighterTool.allCases, HighlighterTool.allCases.indices)
            .map { $0 }
    }()

    private func itemTransform(index: Int, isOffset: Bool) -> CGAffineTransform {
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
                PencilMenu(isMenuShowing: isMenuShowing, menuPosition: .zero, hoverPosition: nil)
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
