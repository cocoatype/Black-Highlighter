//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

struct PencilMenu: View {
    private static let outerDiameter: Double = 398
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

    var body: some View {
        VStack {
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
        }
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
    static var previews: some View {
        PencilMenu()
    }
}
