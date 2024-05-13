//  Created by Geoff Pado on 5/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ReadableWidthKey: EnvironmentKey {
    static let defaultValue = CGFloat.zero
}

public extension EnvironmentValues {
    var readableWidth: CGFloat {
        get { self[ReadableWidthKey.self] }
        set { self[ReadableWidthKey.self] = newValue }
    }
}
