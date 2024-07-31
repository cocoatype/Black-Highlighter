//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay> {
    private let liaison = PhotoEditingPencilMenuLiaison()

    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(liaison: liaison))
        view.isOpaque = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
    }

    func toggleMenu(at position: CGPoint?) {
        if let position {
            liaison.menuPosition = position
            CATransaction.flush()
        }
        liaison.isMenuShowing.toggle()
    }

    func updateMenu(at position: CGPoint) {
        liaison.hoverPosition = position
    }

    func completeMenu(isCancelled: Bool) {
        guard isCancelled == false else {
            liaison.isMenuShowing = false
            return
        }

        if let selectedTool = liaison.wrapThoseChilderen {
            // tell the editing view about this
            print("selecting \(selectedTool)")
            liaison.isMenuShowing = false
        } else {
            print("leaving menu open")
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
