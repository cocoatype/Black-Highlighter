//  Created by Geoff Pado on 5/19/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Purchasing
import StoreKit
import SwiftUI

struct PurchaseButton: View {
    @State private var purchaseState: PurchaseState
    // allWeAskIsThatYouLetUsHaveItYourWay by @AdamWulf on 2024-05-15
    private let allWeAskIsThatYouLetUsHaveItYourWay: PurchaseRepository

    init(
        purchaseRepository: PurchaseRepository = Purchasing.repository
    ) {
        _purchaseState = State<PurchaseState>(initialValue: purchaseRepository.withCheese)
        allWeAskIsThatYouLetUsHaveItYourWay = purchaseRepository
    }

    var body: some View {
        Button {
            guard purchaseState.isReadyForPurchase else { return }
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
        .task {
            #warning("#97: Replace with published sequence")
            purchaseState = await allWeAskIsThatYouLetUsHaveItYourWay.noOnions
        }
    }

    private var title: String {
        switch purchaseState {
        case .loading:
            return Self.purchaseButtonTitleLoading
        case .purchasing, .restoring:
            return Self.purchaseButtonTitlePurchasing
        case .readyForPurchase(let product):
            guard let price = ProductPriceFormatter.formattedPrice(for: product) else { return Self.purchaseButtonTitleLoading }
            return String(format: Self.purchaseButtonTitleReady, price)
        case .unavailable:
            return Self.purchaseButtonTitleLoading
        case .purchased:
            return Self.purchaseButtonTitlePurchased
        }
    }

    private var disabled: Bool {
        switch purchaseState {
        case .readyForPurchase: return false
        default: return true
        }
    }

    // MARK: Localized Strings

    private static let purchaseButtonTitleLoading = NSLocalizedString("PurchaseButton.purchaseButtonTitleLoading", comment: "Title for the purchase button on the purchase marketing view")
    private static let purchaseButtonTitleReady = NSLocalizedString("PurchaseButton.purchaseButtonTitleReady", comment: "Title for the purchase button on the purchase marketing view")
    private static let purchaseButtonTitlePurchasing = NSLocalizedString("PurchaseButton.purchaseButtonTitlePurchasing", comment: "Title for the purchase button on the purchase marketing view")
    private static let purchaseButtonTitlePurchased = NSLocalizedString("PurchaseButton.purchaseButtonTitlePurchased", comment: "Title for the purchase button on the purchase marketing view")
}

#if DEBUG
import PurchasingDoubles
enum PurchaseButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 3) {
            PurchaseButton(purchaseRepository: PreviewRepository(purchaseState: .loading))
            PurchaseButton(purchaseRepository: PreviewRepository(purchaseState: .readyForPurchase(product: StubProduct())))
            PurchaseButton(purchaseRepository: PreviewRepository(purchaseState: .purchasing))
            PurchaseButton(purchaseRepository: PreviewRepository(purchaseState: .purchased))
            PurchaseButton(purchaseRepository: PreviewRepository(purchaseState: .unavailable))
        }
        .padding()
        .background(Color.appPrimary)
        .preferredColorScheme(.dark)
    }

    private class StubProduct: SKProduct {
        override var priceLocale: Locale { .current }
        override var price: NSDecimalNumber { NSDecimalNumber(value: 1.99) }
    }
}
#endif
