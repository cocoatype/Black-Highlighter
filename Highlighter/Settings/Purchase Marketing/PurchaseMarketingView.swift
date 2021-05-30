//  Created by Geoff Pado on 5/18/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingView: View {
    var body: some View {
        PurchaseMarketingStack {
            PurchaseMarketingItem(
                header: "PurchaseMarketingView.autoRedactionsHeader",
                text: "PurchaseMarketingView.autoRedactionsText")
            #if !targetEnvironment(macCatalyst)
            PurchaseMarketingItem(
                header: "PurchaseMarketingView.documentScanningHeader",
                text: "PurchaseMarketingView.documentScanningText")
            #endif
            PurchaseMarketingItem(
                header: "PurchaseMarketingView.supportDevelopmentHeader",
                text: "PurchaseMarketingView.supportDevelopmentText")
            PurchaseButton()
            Spacer()
        }
        .fill()
        .background(Color(.primary))
        .navigationBarItems(trailing: PurchaseRestoreButton())
    }
}

struct PurchaseMarketingView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingView()
            .preferredColorScheme(.dark)
            .environment(\.readableWidth, 288)
    }
}
