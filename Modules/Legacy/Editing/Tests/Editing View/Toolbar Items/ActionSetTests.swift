//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Purchasing
import PurchasingDoubles
import XCTest

@testable import Editing

class ActionSetTests: XCTestCase {
    @Defaults.Value(key: .hideAutoRedactions) private var hideAutoRedactions: Bool

    override func tearDown() {
        hideAutoRedactions = false
        super.tearDown()
    }

    func testCompactTrailingItemsContainsRedactWhenPurchasedAndNotHidden() {
        let set = ActionSet(purchaseState: .purchased)
        hideAutoRedactions = false

        let trailingItems = set.trailingNavigationItems
        XCTAssertTrue(trailingItems.contains(where: { $0 is QuickRedactBarButtonItem }))
    }

    func testCompactTrailingItemsContainsRedactWhenPurchasedAndHidden() {
        let set = ActionSet(purchaseState: .purchased)
        hideAutoRedactions = true

        let trailingItems = set.trailingNavigationItems
        XCTAssertTrue(trailingItems.contains(where: { $0 is QuickRedactBarButtonItem }))
    }

    func testCompactTrailingItemsContainsRedactWhenNotPurchasedAndNotHidden() {
        let set = ActionSet(purchaseState: .unavailable)
        hideAutoRedactions = false

        let trailingItems = set.trailingNavigationItems
        XCTAssertTrue(trailingItems.contains(where: { $0 is QuickRedactBarButtonItem }))
    }

    func testCompactTrailingItemsDoesNotContainRedactWhenNotPurchasedAndHidden() {
        let set = ActionSet(purchaseState: .unavailable)
        hideAutoRedactions = true

        let trailingItems = set.trailingNavigationItems
        XCTAssertFalse(trailingItems.contains(where: { $0 is QuickRedactBarButtonItem }))
    }
}

private extension ActionSet {
    private class Target {}

    init(
        sizeClass: UIUserInterfaceSizeClass = .compact,
        purchaseState: PurchaseState
    ) {
        self.init(
            for: Target(),
            undoManager: nil,
            selectedTool: .magic,
            sizeClass: sizeClass,
            currentColor: .black,
            purchaseRepository: SpyRepository(withCheese: purchaseState)
        )
    }
}
