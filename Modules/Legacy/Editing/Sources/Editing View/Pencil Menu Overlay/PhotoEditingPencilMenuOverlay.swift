//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    private let isMenuShowing: Bool
    private let position: CGPoint

    init(isMenuShowing: Bool, position: CGPoint) {
        self.isMenuShowing = isMenuShowing
        self.position = position
    }

    var body: some View {
        PencilMenu(isMenuShowing: isMenuShowing)
            .position(position)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}
