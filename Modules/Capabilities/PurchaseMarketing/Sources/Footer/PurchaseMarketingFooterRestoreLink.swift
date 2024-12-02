//  Created by Geoff Pado on 12/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit
import SwiftUI

@available(iOS 16.0, *)
struct PurchaseMarketingFooterRestoreLink: View {
    private let usesShortTitle: Bool
    init(usesShortTitle: Bool) {
        self.usesShortTitle = usesShortTitle
    }

    private func restore() {
        Task {
            try await AppStore.sync()
        }
    }

    var body: some View {
        if usesShortTitle {
            PurchaseMarketingFooterLink(title: PurchaseMarketingStrings.PurchaseMarketingFooterRestoreLink.shortTitle, action: restore)
        } else {
            PurchaseMarketingFooterLink(title: PurchaseMarketingStrings.PurchaseMarketingFooterRestoreLink.title, action: restore)
        }
    }
}
