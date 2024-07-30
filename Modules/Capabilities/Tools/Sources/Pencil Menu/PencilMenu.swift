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
            if let adjustedPosition {
                Circle()
                    .foregroundColor(.red)
                    .position(adjustedPosition)
                    .frame(width: 5, height: 5)
            }

            ForEach(Self.indexedTools, id: \.0) { (tool, index) in
                PencilMenuItem(tool: tool)
                    .transformEffect(itemTransform(index: index, isOffset: true))
                    .scaleEffect(scale(at: index))
                    .border(Color.green)
            }
        }
        .border(Color.red)
        .scaleEffect(isMenuShowing ? 1.0 : 0.5)
        .opacity(isMenuShowing ? 1 : 0)
        .animation(.bouncy(duration: 0.3, extraBounce: 0.1), value: isMenuShowing)
        .disabled(isMenuShowing == false)
        .overlay {
            Canvas { context, size in
                context.fill(path(at: 0), with: .color(.red.opacity(0.4)))
                context.fill(path(at: 1), with: .color(.green.opacity(0.4)))
                context.fill(path(at: 2), with: .color(.blue.opacity(0.4)))
            }
        }
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
        Path(ellipseIn: Self.buttonRect)
            .applying(itemTransform(index: index, isOffset: false))
            .applying(CGAffineTransform(translationX: Self.outerDiameter / 2, y: Self.outerDiameter / 2))
//            .applying(itemTransform(index: index))
    }

    private func scale(at index: Int) -> CGSize {
        let regularScale = CGSize(width: 1.0, height: 1.0)
        let expandedScale = CGSize(width: 1.2, height: 1.2)
        guard let adjustedPosition else { return regularScale }
        let shouldScale = path(at: index).contains(adjustedPosition)

        return shouldScale ? expandedScale : regularScale
    }

    private static let buttonRect = CGRect(
        origin: CGPoint(
            x: -18, //Self.outerDiameter / 2 - 18,
            y: -18 //Self.outerDiameter / 2 - 18
        ), size: CGSize(
            width: 36,
            height: 36
        )
    )

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
            .concatenating(isOffset ? centerOffsetTransform : .identity)
            .concatenating(rotateTransform)
            .concatenating(isOffset ? centerResetTransform : .identity)
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
