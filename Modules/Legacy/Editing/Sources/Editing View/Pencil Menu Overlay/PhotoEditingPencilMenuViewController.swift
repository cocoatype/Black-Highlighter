//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay> {
    private var isMenuShowing: Bool = false {
        didSet {
            rootView = PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing)
        }
    }

    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(isMenuShowing: isMenuShowing))
        view.isOpaque = false
        view.backgroundColor = .clear
    }

    func toggleMenu() {
        isMenuShowing.toggle()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
