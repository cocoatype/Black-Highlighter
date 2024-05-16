//  Created by Geoff Pado on 5/21/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import ErrorHandling
import Foundation
import Receipts

struct PreviousPurchasePublisher: Publisher {
    public typealias Output = Bool
    public typealias Failure = Error

    public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        Result.Publisher(Self.hasUserPurchasedProduct()).subscribe(subscriber)
    }

    // MARK: Purchase Validation

    public static func hasUserPurchasedProduct(receiptFetchingMethod: (() throws -> AppReceipt) = ReceiptValidator.validatedAppReceipt) -> Result<Bool, Error> {
        guard ProcessInfo.processInfo.environment.keys.contains("OVERRIDE_PURCHASE") == false else {
            return .success(false)
        }

        do {
            let receipt = try receiptFetchingMethod()
            let originalPurchaseVersion = Int(receipt.purchaseVersion) ?? Int.max
            let earnedFreeProduct = originalPurchaseVersion < Self.freeProductCutoff
            let purchasedProduct = receipt.containsPurchase(withIdentifier: PurchaseConstants.productIdentifier)
            let userHasProduct = earnedFreeProduct || purchasedProduct
            return .success(userHasProduct)
        } catch {
            ErrorHandler().log(error)
            return .success(true)
        }
    }

    private static let freeProductCutoff = 200 // arbitrary build in between 19.3 and 19.4
}
