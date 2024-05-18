//  Created by Geoff Pado on 5/19/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Purchasing
import StoreKit
import SwiftUI

struct PurchaseNavigationLink<Destination: View>: View {
    private let destination: Destination
    private let purchaseRepository: PurchaseRepository
    @State private var purchaseState: PurchaseState

    init(
        purchaseRepository: PurchaseRepository = Purchasing.repository,
        destination: Destination
    ) {
        self.destination = destination
        self.purchaseRepository = purchaseRepository
        self._purchaseState = State<PurchaseState>(initialValue: purchaseRepository.withCheese)
    }

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading) {
                PurchaseTitle()
                PurchaseSubtitle(state: purchaseState)
            }
        }
        .padding(.vertical, 6)
        .settingsCell()
        .task {
            #warning("#97: Replace with published sequence")
            purchaseState = await purchaseRepository.noOnions
        }
    }
}

#if DEBUG
import PurchasingDoubles
enum PurchaseNavigationLinkPreviews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            PurchaseNavigationLink(purchaseRepository: PreviewRepository(purchaseState: .loading), destination: Text?.none)
            PurchaseNavigationLink(purchaseRepository: PreviewRepository(purchaseState: .readyForPurchase(product: PreviewProduct())), destination: Text?.none)
        }.preferredColorScheme(.dark)
    }
}
#endif
