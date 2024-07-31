//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    @ObservedObject private var liaison: PhotoEditingPencilMenuLiaison

    init(liaison: PhotoEditingPencilMenuLiaison) {
        self.liaison = liaison
    }

    var body: some View {
        PencilMenu(
            isMenuShowing: liaison.isMenuShowing,
            menuPosition: liaison.menuPosition,
            hoverPosition: liaison.hoverPosition,
            selectedTool: $liaison.wrapThoseChilderen
        )
    }
}
