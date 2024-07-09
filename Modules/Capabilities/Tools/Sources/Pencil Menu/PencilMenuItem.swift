//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

struct PencilMenuItem: View {
    static let diameter: Double = 36

    private let tool: HighlighterTool
    init(tool: HighlighterTool) {
        self.tool = tool
    }

    var body: some View {
        Circle()
            .fill(Color.cellBackground)
            .frame(width: Self.diameter, height: Self.diameter)
            .overlay(
                tool.toolsImage.swiftUIImage
                    .foregroundColor(.white)
            )
    }
}

enum PencilMenuItemPreviews: PreviewProvider {
    static var previews: some View {
        HStack {
            ForEach(HighlighterTool.allCases, id: \.self) { tool in
                PencilMenuItem(tool: tool)
            }
        }
    }
}
