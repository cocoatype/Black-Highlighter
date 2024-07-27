//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

public class DismissEvent: UIEvent {
    public let asset: PHAsset?
    init(asset: PHAsset?) {
        self.asset = asset
        super.init()
    }
}
