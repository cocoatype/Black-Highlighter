//  Created by Geoff Pado on 8/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PencilMenuItemLabel: View {
    private let tool: HighlighterTool
    init(tool: HighlighterTool) {
        self.tool = tool
    }

    var body: some View {
        Circle()
            .fill(Color.cellBackground)
            .frame(width: PencilMenuItem.diameter, height: PencilMenuItem.diameter)
            .overlay(
                tool.toolsImage.swiftUIImage
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    HStack {
        ForEach(HighlighterTool.allCases, id: \.self) {
            PencilMenuItemLabel(tool: $0)
        }
    }
}
