//  Created by Geoff Pado on 8/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class DismissBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
        self.style = .done
        self.title = EditingStrings.DismissBarButtonItem.title
        self.action = #selector(PhotoEditingActions.dismissPhotoEditingViewController)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
