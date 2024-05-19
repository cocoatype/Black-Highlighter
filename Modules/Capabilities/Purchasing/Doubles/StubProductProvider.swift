//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing

public struct StubProductProvider: ProductProvider {
    public init() {}

    public var product: any PurchaseProduct {
        PreviewProduct()
    }
}
