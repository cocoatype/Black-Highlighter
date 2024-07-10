//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    @State private var isMenuShowing: Bool
    private let menuDisplay: PhotoEditingPencilMenuViewController.MenuDisplay

    init(menuDisplay: PhotoEditingPencilMenuViewController.MenuDisplay) {
        self.menuDisplay = menuDisplay
        _isMenuShowing = State(initialValue: menuDisplay.isMenuShowing)
    }

    var body: some View {
        ZStack {
            PencilMenu(isMenuShowing: $isMenuShowing)
        }
        .onReceive(menuDisplay.$isMenuShowing) { newValue in
            withAnimation {
                isMenuShowing = newValue
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}
