//  Created by Geoff Pado on 5/17/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Editing
import Introspect
import Purchasing
import StoreKit
import SwiftUI

struct SettingsView: View {
    @Environment(\.purchaseStatePublisher) private var purchaseStatePublisher: PurchaseStatePublisher
    @State private var purchaseState: PurchaseState
    @State private var selectedURL: URL?
    private let dismissAction: () -> Void
    private let readableWidth: CGFloat

    init(purchaseState: PurchaseState = .loading, readableWidth: CGFloat = .zero, dismissAction: @escaping (() -> Void)) {
        self._purchaseState = State<PurchaseState>(initialValue: purchaseState)
        self.dismissAction = dismissAction
        self.readableWidth = readableWidth
    }

    var body: some View {
        SettingsNavigationView {
            SettingsList(dismissAction: dismissAction) {
                SettingsContentGenerator(state: purchaseState).content
            }.navigationBarTitle("SettingsViewController.navigationTitle", displayMode: .inline)
        }
        .environment(\.readableWidth, readableWidth)
        .onAppReceive(purchaseStatePublisher.receive(on: RunLoop.main)) { newState in
            purchaseState = newState
        }
    }
}

struct SettingsViewPreviews: PreviewProvider {
    static let states = [PurchaseState.loading, .readyForPurchase(product: MockProduct()), .purchased]

    static var previews: some View {
        ForEach(states) { state in
            SettingsView(purchaseState: state, readableWidth: 288, dismissAction: {})
                .previewDevice("iPhone 12 Pro Max")
        }
    }

    private class MockProduct: SKProduct {
        override var priceLocale: Locale { .current }
        override var price: NSDecimalNumber { NSDecimalNumber(value: 1.99) }
    }
}
