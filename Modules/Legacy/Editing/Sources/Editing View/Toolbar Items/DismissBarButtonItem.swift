//  Created by Geoff Pado on 8/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

class DismissBarButtonItem: UIBarButtonItem {
    private let asset: PHAsset?
    init(asset: PHAsset?) {
        self.asset = asset
        super.init()
        self.style = .done
        self.title = EditingStrings.DismissBarButtonItem.title
        self.target = self
        self.action = #selector(handleButton)
    }

    @objc private func handleButton() {
        let event = DismissEvent(asset: asset)
        UIApplication.shared.sendAction(#selector(PhotoEditingActions.dismissPhotoEditingViewController), to: nil, from: self, for: event)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
