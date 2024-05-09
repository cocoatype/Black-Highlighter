//  Created by Geoff Pado on 4/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import Photos
import Redactions
import UIKit

protocol PhotoEditorPresenting {
    func presentPhotoEditingViewController(for asset: PHAsset, redactions: [Redaction]?, animated: Bool)
    func presentPhotoEditingViewController(for image: UIImage, redactions: [Redaction]?, animated: Bool, completionHandler: ((UIImage) -> Void)?)
}

extension UIResponder {
    var photoEditorPresenter: PhotoEditorPresenting? {
        if let presenter = (self as? PhotoEditorPresenting) {
            return presenter
        }

        return next?.photoEditorPresenter
    }
}
