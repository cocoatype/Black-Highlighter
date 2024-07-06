//  Created by Geoff Pado on 5/19/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Purchasing
import StoreKit
import SwiftUI

struct PurchaseButton: View {
    @State private var purchaseState: PurchaseState
    // allWeAskIsThatYouLetUsHaveItYourWay by @AdamWulf on 2024-05-15
    private let allWeAskIsThatYouLetUsHaveItYourWay: any PurchaseRepository

    init(
        purchaseRepository: any PurchaseRepository = Purchasing.repository
    ) {
        _purchaseState = State<PurchaseState>(initialValue: purchaseRepository.withCheese)
        allWeAskIsThatYouLetUsHaveItYourWay = purchaseRepository
    }

    var body: some View {
        Button {
            guard purchaseState.isReadyForPurchase else { return }
            purchaseState = .purchasing
            Task {
                purchaseState = await allWeAskIsThatYouLetUsHaveItYourWay.purchase()
            }
        } label: {
            Text(title)
                .underline()
                .font(.app(textStyle: .headline))
                .foregroundColor(disabled ? .primaryExtraLight : .white)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(disabled)
        .onReceive(allWeAskIsThatYouLetUsHaveItYourWay.purchaseStates.eraseToAnyPublisher()) { newState in
            purchaseState = newState
        }
    }

    private var title: String {
        switch purchaseState {
        case .loading:
            return Strings.loadingTitle
        case .purchasing, .restoring:
            return Strings.purchasingTitle
        case .readyForPurchase(let product):
            return Strings.readyTitle(product.displayPrice)
        case .unavailable:
            return Strings.loadingTitle
        case .purchased:
            return Strings.purchasedTitle
        }
    }

    private var disabled: Bool {
        switch purchaseState {
        case .readyForPurchase: return false
        default: return true
        }
    }

    private typealias Strings = PurchaseMarketingStrings.PurchaseButton
}

#if DEBUG
import PurchasingDoubles
enum PurchaseButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 3) {
            PurchaseButton(state: .loading)
            PurchaseButton(state: .readyForPurchase(product: PreviewProduct()))
            PurchaseButton(state: .purchasing)
            PurchaseButton(state: .purchased)
            PurchaseButton(state: .unavailable)
        }
        .padding()
        .background(Color.appPrimary)
        .preferredColorScheme(.dark)
    }
}

extension PurchaseButton {
    init(state: PurchaseState) {
        self.init(purchaseRepository: PreviewRepository(purchaseState: state))
    }
}
#endif
