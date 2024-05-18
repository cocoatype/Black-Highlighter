//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Combine
import Purchasing
import TestHelpersInterface

public struct SpyRepository: PurchaseRepository {
    public init(
        withCheese: PurchaseState = .loading,
        noOnions: PurchaseState = .loading,
        purchaseStates: any Publisher<PurchaseState, Never> = Just(.loading),
        startExpectation: Expectation? = nil,
        purchaseExpectation: Expectation? = nil,
        purchaseResponse: PurchaseState = .loading,
        restoreExpectation: Expectation? = nil,
        restoreResponse: PurchaseState = .loading
    ) {
        self.withCheese = withCheese
        self.noOnions = noOnions
        self.purchaseStates = purchaseStates
        self.startExpectation = startExpectation
        self.purchaseExpectation = purchaseExpectation
        self.purchaseResponse = purchaseResponse
        self.restoreExpectation = restoreExpectation
        self.restoreResponse = restoreResponse
    }

    public var withCheese: PurchaseState = .loading
    public var noOnions: PurchaseState = .loading
    public var purchaseStates: any Publisher<PurchaseState, Never>

    public var startExpectation: Expectation?
    public func start() {
        startExpectation?.fulfill()
    }
    
    public var purchaseExpectation: Expectation?
    public var purchaseResponse: PurchaseState = .loading
    public func purchase() async -> PurchaseState {
        purchaseExpectation?.fulfill()
        return purchaseResponse
    }
    
    public var restoreExpectation: Expectation?
    public var restoreResponse: PurchaseState = .loading
    public func restore() async -> PurchaseState {
        restoreExpectation?.fulfill()
        return restoreResponse
    }
}
