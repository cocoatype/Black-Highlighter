//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    private let isMenuShowing: Bool

    init(isMenuShowing: Bool) {
        self.isMenuShowing = isMenuShowing
    }

    var body: some View {
        ZStack {
            PencilMenu(isMenuShowing: isMenuShowing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}
