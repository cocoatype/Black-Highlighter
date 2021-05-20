//  Created by Geoff Pado on 5/17/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import StoreKit
import SwiftUI

struct SettingsView: View {
    private let purchaser: Purchaser
    private let readableWidth: CGFloat
    init(readableWidth: CGFloat = .zero, purchaser: Purchaser) {
        self.purchaser = purchaser
        self.readableWidth = readableWidth
    }

    var body: some View {
        SettingsNavigationView {
            SettingsList {
                SettingsContentGenerator(state: purchaser.state).content
            }.navigationBarTitle("Settings", displayMode: .inline)
        }.environment(\.readableWidth, readableWidth)
    }
}

struct SettingsViewPreviews: PreviewProvider {
    static let states = [PurchaseState.loading, .readyForPurchase(product: MockProduct()), .purchased]

    static var previews: some View {
        ForEach(states) { state in
            SettingsView(readableWidth: 288, purchaser: MockPurchaser(state: state))
                .previewDevice("iPhone 12 Pro Max")
                .preferredColorScheme(.dark)
        }
    }

    private class MockPurchaser: Purchaser {
        init(state: PurchaseState) {
            mockState = state
        }
        private let mockState: PurchaseState
        override var state: PurchaseState { return mockState }
    }

    private class MockProduct: SKProduct {
        override var priceLocale: Locale { .current }
        override var price: NSDecimalNumber { NSDecimalNumber(value: 1.99) }
    }
}

extension PurchaseState: Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .loading: hasher.combine("loading")
        case .purchased: hasher.combine("purchased")
        case .unavailable: hasher.combine("unavailable")
        case .purchasing(let operation): hasher.combine(operation)
        case .readyForPurchase(let product):
            hasher.combine(product)
        case .restoring(let operation):
            hasher.combine(operation)
        }
    }

    static func == (lhs: PurchaseState, rhs: PurchaseState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.loading, _): return false
        case (.purchased, .purchased): return true
        case (.purchased, _): return false
        case (.unavailable, .unavailable): return true
        case (.unavailable, _): return false
        case (.purchasing(let lhsOperation), .purchasing(let rhsOperation)): return lhsOperation == rhsOperation
        case (.purchasing, _): return false
        case (.readyForPurchase(let lhsProduct), .readyForPurchase(let rhsProduct)): return lhsProduct == rhsProduct
        case (.readyForPurchase, _): return false
        case (.restoring(let lhsOperation), .restoring(let rhsOperation)): return lhsOperation == rhsOperation
        case (.restoring, _): return false
        }
    }

    var id: PurchaseState { return self }
}
