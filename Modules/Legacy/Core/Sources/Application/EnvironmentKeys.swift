//  Created by Geoff Pado on 4/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing
import SwiftUI

struct ReadableWidthKey: EnvironmentKey {
    static let defaultValue = CGFloat.zero
}

struct PurchaseStatePublisherKey: EnvironmentKey {
    static let defaultValue = PurchaseStatePublisher()
}

extension EnvironmentValues {
    var readableWidth: CGFloat {
        get { self[ReadableWidthKey.self] }
        set { self[ReadableWidthKey.self] = newValue }
    }

    var purchaseStatePublisher: PurchaseStatePublisher {
        get { self[PurchaseStatePublisherKey.self] }
        set { self[PurchaseStatePublisherKey.self] = newValue }
    }
}
