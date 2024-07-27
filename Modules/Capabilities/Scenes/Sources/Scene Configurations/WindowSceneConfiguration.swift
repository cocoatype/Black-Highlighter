//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class WindowSceneConfiguration: UISceneConfiguration {
    init(name: String) {
        super.init(name: name, sessionRole: .windowApplication)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
