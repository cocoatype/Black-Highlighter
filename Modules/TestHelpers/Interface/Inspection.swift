//  Created by Geoff Pado on 12/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Combine
import SwiftUI

public final class Inspection<V> {
    public let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    public init() {}

    public func visit(_ view: V, _ line: UInt) {
        callbacks.removeValue(forKey: line)?(view)
    }
}

public extension View {
    func makeInspectable<RootView: View>(with inspection: Inspection<RootView>, rootView: RootView) -> some View {
        self.onReceive(inspection.notice) { inspection.visit(rootView, $0) }
    }
}
