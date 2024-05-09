//  Created by Geoff Pado on 5/21/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import StoreKit

enum ProductPriceFormatter {
    static func formattedPrice(for product: SKProduct) -> String? {
        if product.priceLocale != Self.priceFormatter.locale {
            Self.priceFormatter.locale = product.priceLocale
        }

        return Self.priceFormatter.string(from: product.price)
    }

    private static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        return formatter
    }()
}
