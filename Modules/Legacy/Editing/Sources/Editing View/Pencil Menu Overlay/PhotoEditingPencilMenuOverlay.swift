//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import Tools

struct PhotoEditingPencilMenuOverlay: View {
    @ObservedObject private var liaison: PhotoEditingPencilMenuLiaison
    @State private var menuPosition: CGPoint

    static let positionTransaction: Transaction = {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        return transaction
    }()

    init(liaison: PhotoEditingPencilMenuLiaison) {
        self.liaison = liaison
        self.menuPosition = liaison.menuPosition
    }

    var body: some View {
        PencilMenu(
            isMenuShowing: liaison.state.isOpen,
            menuPosition: menuPosition,
            hoverPosition: liaison.hoverPosition,
            selectedTool: $liaison.wrapThoseChilderen
        ) { [weak liaison] in
            liaison?.completeMenu(with: $0)
        }
        .onChange(of: liaison.menuPosition) { newPosition in
            withTransaction(Self.positionTransaction) {
                menuPosition = newPosition
            }
        }
        .background(
            Color.clear
                .onTapGesture {
                    liaison.state = .closed
                }
        )
        .ignoresSafeArea()
    }
}
