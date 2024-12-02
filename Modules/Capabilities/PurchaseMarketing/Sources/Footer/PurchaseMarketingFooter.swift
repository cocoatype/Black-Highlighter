//  Created by Geoff Pado on 12/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Purchasing
import SwiftUI

@available(iOS 16.0, *)
struct PurchaseMarketingFooter: View {
    var body: some View {
        PurchaseMarketingFooterContents()
            .frame(maxWidth: .infinity, minHeight: 140)
    }
}
