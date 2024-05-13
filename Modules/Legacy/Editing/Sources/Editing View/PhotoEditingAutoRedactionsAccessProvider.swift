//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AutoRedactionsUI
import Purchasing
import UIKit
import Unpurchased

class PhotoEditingAutoRedactionsAccessProvider: NSObject {
    func autoRedactionsAccessViewController(learnMoreAction: UnpurchasedFeature.LearnMoreAction) -> UIViewController {
        if purchased {
            return AutoRedactionsAccessViewController()
        } else {
            return UnpurchasedAlertControllerFactory()
                .alertController(for: .autoRedactions(learnMoreAction: nil))
        }
    }

    private var purchased: Bool {
        do {
            return try PreviousPurchasePublisher
                .hasUserPurchasedProduct()
                .get()
        } catch { return false }
    }
}
