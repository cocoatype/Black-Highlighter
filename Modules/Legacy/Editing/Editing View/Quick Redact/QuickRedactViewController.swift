//  Created by Geoff Pado on 4/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

@available(iOS 15, *)
class QuickRedactViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        sheetPresentationController?.detents = [.medium()]
    }

    override func loadView() {
        view = QuickRedactView()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
