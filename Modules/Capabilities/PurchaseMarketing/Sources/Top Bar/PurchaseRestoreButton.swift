//  Created by Geoff Pado on 5/24/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Purchasing
import StoreKit
import SwiftUI

struct PurchaseRestoreButton: View {
    @State private var purchaseState: PurchaseState
    private let purchaseRepository: any PurchaseRepository

    init(purchaseRepository: any PurchaseRepository = Purchasing.repository) {
        _purchaseState = State<PurchaseState>(initialValue: purchaseRepository.withCheese)
        self.purchaseRepository = purchaseRepository
    }

    var body: some View {
        Button {
            purchaseState = .restoring
            Task {
                purchaseState = await purchaseRepository.restore()
            }
        } label: {
            Text("PurchaseMarketingViewController.restoreButtonTitle")
                .underline()
                .font(.app(textStyle: .headline))
                .foregroundColor(disabled ? .primaryExtraLight : .white)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(disabled)
        .task {
            #warning("#97: Replace with published sequence")
            purchaseState = await purchaseRepository.noOnions
        }
    }

    private var disabled: Bool {
        switch purchaseState {
        case .readyForPurchase: return false
        default: return true
        }
    }
}

#if DEBUG
import PurchasingDoubles
enum PurchaseRestoreButtonPreviews: PreviewProvider {
    static let states = [
        PurchaseState.loading,
        .readyForPurchase(product: PreviewProduct()),
        .purchasing,
        .purchased,
        .unavailable,
    ]

    static var previews: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(states) { state in
                PurchaseRestoreButton(purchaseRepository: PreviewRepository(purchaseState: state))
            }
        }
        .padding()
        .background(Color.appPrimary)
        .preferredColorScheme(.dark)
    }
}
#endif
