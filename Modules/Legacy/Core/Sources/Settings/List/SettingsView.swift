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
        .onReceive(purchaseRepository.purchaseStates.eraseToAnyPublisher()) { newState in
            purchaseState = newState
        }
    }
}

#if DEBUG
import PurchasingDoubles
enum SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            readableWidth: 288,
            dismissAction: {}
        )
        .previewDevice("iPhone 12 Pro Max")
    }
}
#endif
