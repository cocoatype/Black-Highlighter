//  Created by Geoff Pado on 7/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15.0, *)
struct PencilMenuBackground: View {
    private static let itemCount: Int = HighlighterTool.allCases.count
    private static var lineWidth: Double {
        PencilMenuItem.diameter + PencilMenu.padding
    }

    private static var maxTrim: Double {
        let itemLength = PencilMenuItem.diameter * itemCount
        let paddingLength = PencilMenu.padding * itemCount
        let requiredLength = itemLength + paddingLength - lineWidth
        return requiredLength / PencilMenu.outerCircumference
    }
    
    var body: some View {
        Circle()
            .trim(from: 0, to: Self.maxTrim)
            .stroke(Color.primaryDark, style: StrokeStyle(lineWidth: Self.lineWidth, lineCap: .round))
            .frame(width: PencilMenu.outerDiameter, height: PencilMenu.outerDiameter)
    }
}
