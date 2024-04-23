//  Created by Geoff Pado on 4/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class QuickRedactView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
