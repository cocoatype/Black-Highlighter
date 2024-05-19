//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing

public struct StubVersionProvider: PurchaseVersionProvider {
    public let originalPurchaseVersion: Int
    public init(originalPurchaseVersion: Int) {
        self.originalPurchaseVersion = originalPurchaseVersion
    }
}
