//  Created by Geoff Pado on 5/31/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

public extension NotificationCenter {
    func addObserver<ValueType>(for value: Defaults.Value<ValueType>, block: @MainActor @escaping @Sendable () -> Void) -> any NSObjectProtocol {
        addObserver(forName: value.valueDidChange, object: nil, queue: .main, using: { _ in
            Task { @MainActor in
                block()
            }
        })
    }
}
