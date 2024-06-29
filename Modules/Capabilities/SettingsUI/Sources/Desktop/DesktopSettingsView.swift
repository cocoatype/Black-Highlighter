//  Created by Geoff Pado on 9/27/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import PurchaseMarketing
import Purchasing
import SwiftUI

struct DesktopSettingsView: View {
    @State private var purchaseState: PurchaseState
    private let readableWidth: CGFloat
    private let purchaseRepository: any PurchaseRepository

    init(
        readableWidth: CGFloat = .zero,
        purchaseRepository: any PurchaseRepository = Purchasing.repository
    ) {
        _purchaseState = State(initialValue: purchaseRepository.withCheese)
        self.readableWidth = readableWidth
        self.purchaseRepository = purchaseRepository
    }

    var body: some View {
        Group {
            if purchaseState == .purchased {
                DesktopAutoRedactionsListViewControllerRepresentable()
            } else {
                PurchaseMarketingView()
            }
        }
        .environment(\.readableWidth, readableWidth)
        .onReceive(purchaseRepository.purchaseStates.eraseToAnyPublisher()) { newState in
            purchaseState = newState
        }
    }
}

#if DEBUG
import PurchasingDoubles
struct DesktopSettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            DesktopSettingsView(readableWidth: 288, purchaseRepository: PreviewRepository(purchaseState: .loading))
            DesktopSettingsView(readableWidth: 288, purchaseRepository: PreviewRepository(purchaseState: .purchased))
        }.preferredColorScheme(.dark)
    }
}
#endif