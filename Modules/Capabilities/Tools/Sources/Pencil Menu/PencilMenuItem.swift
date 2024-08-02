//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

struct PencilMenuItem: View {
    static let diameter: Double = 36

    private let tool: HighlighterTool
    private let handler: () -> Void
    init(tool: HighlighterTool, handler: @escaping () -> Void) {
        self.tool = tool
        self.handler = handler
    }

    var body: some View {
        Button(action: handler) {
            PencilMenuItemLabel(tool: tool)
                .frame(width: PencilMenuItem.diameter, height: PencilMenuItem.diameter)
                .background(Color.clear)
                .contentShape(Circle())
        }
    }
}

#Preview {
    HStack {
        ForEach(HighlighterTool.allCases, id: \.self) { tool in
            PencilMenuItem(tool: tool) {}
        }
    }
}
