//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay> {
    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(menuDisplay: menuDisplay))
        view.isOpaque = false
        view.backgroundColor = .clear
    }

    let menuDisplay = MenuDisplay()
    func toggleMenu() {
        menuDisplay.isMenuShowing.toggle()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    class MenuDisplay: NSObject, ObservableObject {
        @Published var isMenuShowing = false
    }
}
