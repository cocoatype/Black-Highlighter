//  Created by Geoff Pado on 5/18/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StoreKit

struct StoreProductProvider: ProductProvider {
    var product: any PurchaseProduct {
        get async throws {
            let products = try await Product.products(for: [PurchaseConstants.productIdentifier])
            guard let product = products.first else {
                throw PurchaseError.productNotFound(identifier: PurchaseConstants.productIdentifier)
            }

            return product
        }
    }
}
