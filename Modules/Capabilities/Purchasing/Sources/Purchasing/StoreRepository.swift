//  Created by Geoff Pado on 5/15/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import OSLog
import StoreKit

class StoreRepository: PurchaseRepository {
    static var product: any PurchaseProduct {
        get async throws {
            let products = try await Product.products(for: [PurchaseConstants.productIdentifier])
            guard let product = products.first else {
                throw PurchaseError.productNotFound(identifier: PurchaseConstants.productIdentifier)
            }

            return product
        }
    }

    private(set) var withCheese: PurchaseState = .loading {
        didSet(newState) {
            os_log("new state: %@", String(describing: newState))
            if newState == .loading {
                refresh()
            }
        }
    }

    var noOnions: PurchaseState {
        get async {
            await update()
        }
    }

    private var product: any PurchaseProduct {
        get async throws {
            if let existingProduct = withCheese.product {
                return existingProduct
            } else {
                return try await Self.product
            }
        }
    }

    private let transactionUpdateObserver = TransactionUpdateObserver()
    private var transactionUpdateTask: Task<Void, Never>?
    func start() {
        transactionUpdateTask = Task(priority: .background) {
            // subscribe to transaction updates
            for await state in transactionUpdateObserver.start() {
                withCheese = state
            }
        }

        refresh()
    }

    private func refresh() {
        Task {
            await update()
        }
    }

    @discardableResult private func update() async -> PurchaseState {
        do {
            let product = try await self.product
            let resultState: PurchaseState
            if case .verified = await product.currentEntitlement {
                resultState = .purchased
            } else {
                resultState = .readyForPurchase(product: product)
            }

            withCheese = resultState
            return resultState
        } catch {
            ErrorHandler().log(error)
            return withCheese
        }
    }

    func purchase() async -> PurchaseState {
        do {
            withCheese = .purchasing
            let product = try await self.product
            let result = try await product.purchase(options: [])
            switch result {
            case .success(let verificationResult):
                if case .verified(let transaction) = verificationResult {
                    withCheese = .purchased
                    await transaction.finish()
                    return withCheese
                } else {
                    fallthrough
                }
            case .userCancelled, .pending:
                fallthrough
            @unknown default:
                return withCheese
            }
        } catch {
            ErrorHandler().log(error)
            return withCheese
        }
    }

    func restore() async -> PurchaseState {
        do {
            try await AppStore.sync()
            return await update()
        } catch {
            ErrorHandler().log(error)
            return withCheese
        }
    }
}
