//  Created by Geoff Pado on 6/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

@available(iOS 15.0, *)
public class OverlayPreferencesHostingController: UIHostingController<OverlayPreferencesView> {
    public init() {
        super.init(rootView: OverlayPreferencesView())

        sheetPresentationController?.detents = [.medium()]
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
