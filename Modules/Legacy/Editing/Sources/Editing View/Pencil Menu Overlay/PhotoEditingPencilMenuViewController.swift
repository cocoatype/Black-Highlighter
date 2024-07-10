//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay> {
    private var isMenuShowing: Bool = false
    private var position: CGPoint = .zero

    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing, position: position))
        view.isOpaque = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
    }

    func toggleMenu(at position: CGPoint?) {
        if let position, isMenuShowing == false {
            self.position = position
            updateRootView()
        }

        CATransaction.flush()

        isMenuShowing.toggle()
        updateRootView()
    }

    private func updateRootView() {
        rootView = PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing, position: position)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
