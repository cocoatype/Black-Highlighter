//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    @ObservedObject private var hoverPositionHolder: PhotoEditingPencilMenuHoverPositionHolder
    private let isMenuShowing: Bool
    private let menuPosition: CGPoint

    init(isMenuShowing: Bool, position: CGPoint, hoverPositionHolder: PhotoEditingPencilMenuHoverPositionHolder) {
        self.isMenuShowing = isMenuShowing
        self.menuPosition = position
        self.hoverPositionHolder = hoverPositionHolder
    }

    var body: some View {
        if #available(iOS 15, *) {
            PencilMenu(
                isMenuShowing: isMenuShowing,
                menuPosition: menuPosition,
                hoverPosition: hoverPositionHolder.hoverPosition
            )
            .position(menuPosition)
        }
    }
}
