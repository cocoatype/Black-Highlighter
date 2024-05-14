//  Created by Geoff Pado on 5/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseStatePublisherKey: EnvironmentKey {
    static let defaultValue = PurchaseStatePublisher()
}

public extension EnvironmentValues {
    var purchaseStatePublisher: PurchaseStatePublisher {
        get { self[PurchaseStatePublisherKey.self] }
        set { self[PurchaseStatePublisherKey.self] = newValue }
    }
}
