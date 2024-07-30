//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay> {
    private var isMenuShowing: Bool = false
    private var position: CGPoint = .zero
    private let positionHolder = PhotoEditingPencilMenuHoverPositionHolder()

    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing, position: position, hoverPositionHolder: positionHolder))
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

    func updateMenu(at position: CGPoint) {
        positionHolder.hoverPosition = position
//        rootView.updateHoverPosition(to: position)
    }

    private func updateRootView() {
        rootView = PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing, position: position, hoverPositionHolder: positionHolder)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class PhotoEditingPencilMenuHoverPositionHolder: NSObject, ObservableObject {
    @Published var hoverPosition: CGPoint?
}
