//  Created by Geoff Pado on 12/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Purchasing
import SwiftUI

@available(iOS 16.0, *)
struct PurchaseMarketingFooterContents: View {
    var body: some View {
        VStack(spacing: 20) {
            PurchaseMarketingFooterPurchaseButton()
            PurchaseMarketingFooterLinkSection()
        }.padding()
    }
}
