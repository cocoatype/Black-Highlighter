//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Editing
import UIKit

class PhotoNavigationController: NavigationController {
    init(image: UIImage) {
        super.init(rootViewController: PhotoEditingViewController(image: image))
        isToolbarHidden = false
        setNavigationBarHidden(true, animated: false)
    }

    // MARK: Boilerplate

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
