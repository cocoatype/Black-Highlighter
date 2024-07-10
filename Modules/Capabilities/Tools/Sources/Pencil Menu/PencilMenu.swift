//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

public struct PencilMenu: View {
    private static let outerDiameter: Double = 298
    private static let itemDiameter: Double = PencilMenuItem.diameter
    private static let padding: Double = 8
    private static let itemCount: Int = HighlighterTool.allCases.count
    private static var lineWidth: Double {
        itemDiameter + padding
    }

    private static var maxTrim: Double {
        let itemLength = itemDiameter * itemCount
        let paddingLength = padding * itemCount
        let requiredLength = itemLength + paddingLength - lineWidth
        return requiredLength / outerCircumference
    }

    private let isMenuShowing: Bool
    public init(isMenuShowing: Bool) {
        self.isMenuShowing = isMenuShowing
    }

    public var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: Self.maxTrim)
                .stroke(Color.primaryDark, style: StrokeStyle(lineWidth: Self.lineWidth, lineCap: .round))
                .frame(width: Self.outerDiameter, height: Self.outerDiameter)
            ForEach(Self.indexedTools, id: \.0) { (tool, index) in
                PencilMenuItem(tool: tool)
                    .transformEffect(itemTransform(index: index))
            }
        }
        .scaleEffect(isMenuShowing ? 1.0 : 0.5)
        .opacity(isMenuShowing ? 1 : 0)
        .animation(.bouncy(duration: 0.3, extraBounce: 0.1), value: isMenuShowing)
        .disabled(isMenuShowing == false)
    }

    private static let indexedTools = zip(HighlighterTool.allCases, HighlighterTool.allCases.indices)
            .map(\.self)

    private static var outerCircumference: Double {
        return Double.pi * outerDiameter
    }

    private func itemTransform(index: Int) -> CGAffineTransform {
        let offset = (Self.padding + Self.itemDiameter) * index
        let offsetPercent = offset / Self.outerCircumference
        let rotation = offsetPercent * (Double.pi * 2)

        let translateTransform = CGAffineTransform(translationX: Self.outerDiameter / 2, y: 0)
        let centerOffsetTransform = CGAffineTransform(translationX: Self.itemDiameter / -2, y: Self.itemDiameter / -2)
        let rotateTransform = CGAffineTransform(rotationAngle: rotation)
        let centerResetTransform = CGAffineTransform(translationX: Self.itemDiameter / 2, y: Self.itemDiameter / 2)
        return translateTransform
            .concatenating(centerOffsetTransform)
            .concatenating(rotateTransform)
            .concatenating(centerResetTransform)
    }
}

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
                PencilMenu(isMenuShowing: isMenuShowing)
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
