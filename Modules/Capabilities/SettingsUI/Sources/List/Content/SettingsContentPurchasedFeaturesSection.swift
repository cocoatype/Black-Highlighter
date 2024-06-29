//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AutoRedactionsUI
import Defaults
import PurchaseMarketing
import Purchasing
import SwiftUI

struct SettingsContentPurchasedFeaturesSection: View {
    private let purchaseState: PurchaseState
    init(state: PurchaseState) {
        self.purchaseState = state
    }

    @Defaults.Value(key: .hideAutoRedactions) private var hideAutoRedactions: Bool
    
    var body: some View {
        Section {
            if purchaseState != .purchased {
                PurchaseNavigationLink(destination: PurchaseMarketingView())
            }

            if purchaseState != .purchased && hideAutoRedactions == false {
                SettingsAlertButton(SettingsUIStrings.SettingsContentProvider.Item.autoRedactions)
            }

            if purchaseState == .purchased {
                SettingsNavigationLink(SettingsUIStrings.SettingsContentProvider.Item.autoRedactions, destination: AutoRedactionsEditView().background(Color.appPrimary.edgesIgnoringSafeArea(.all)))
            }
        }
    }
}
