//  Created by Geoff Pado on 12/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 16.0, *)
struct PurchaseMarketingFooterLink: View {
    private let title: String
    private let action: () -> Void
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(title, action: action)
            .lineLimit(nil)
            .font(.footnote)
            .tint(.white)
    }
}
