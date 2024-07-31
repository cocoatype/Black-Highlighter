//  Created by Geoff Pado on 7/30/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Tools

class PhotoEditingPencilMenuLiaison: NSObject, ObservableObject {
    @Published var menuPosition: CGPoint = .zero
    @Published var isMenuShowing: Bool = false
    @Published var hoverPosition: CGPoint?

    // wrapThoseChilderen by @KaenAitch on 2024-07-29
    // the selected highlighter tool, if any
    @Published var wrapThoseChilderen: HighlighterTool?
}
