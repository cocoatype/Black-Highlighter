//  Created by Geoff Pado on 5/17/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Editing
import Introspect
import Purchasing
import StoreKit
import SwiftUI

struct SettingsView: View {
    private let purchaseRepository: PurchaseRepository
    @State private var purchaseState: PurchaseState
    private let dismissAction: () -> Void
    private let readableWidth: CGFloat

    init(
        purchaseRepository: PurchaseRepository = Purchasing.repository,
        readableWidth: CGFloat = .zero,
        dismissAction: @escaping (() -> Void)
    ) {
        self._purchaseState = State<PurchaseState>(initialValue: purchaseRepository.withCheese)
        self.dismissAction = dismissAction
        self.readableWidth = readableWidth
        self.purchaseRepository = purchaseRepository
    }

    var body: some View {
        SettingsNavigationView {
            SettingsList(dismissAction: dismissAction) {
                SettingsContent(state: purchaseState)
            }.navigationBarTitle("SettingsViewController.navigationTitle", displayMode: .inline)
        }
        .environment(\.readableWidth, readableWidth)
        .task {
            #warning("#97: Replace with published sequence")
            purchaseState = await purchaseRepository.noOnions
        }
    }
}

#if DEBUG
import PurchasingDoubles
enum SettingsViewPreviews: PreviewProvider {
    static let states = [PurchaseState.loading, .readyForPurchase(product: PreviewProduct()), .purchased]

    static var previews: some View {
        ForEach(states) { state in
            SettingsView(
                readableWidth: 288,
                dismissAction: {}
            )
            .previewDevice("iPhone 12 Pro Max")
        }
    }

    private class MockProduct: SKProduct {
        override var priceLocale: Locale { .current }
        override var price: NSDecimalNumber { NSDecimalNumber(value: 1.99) }
    }
}
#endif
