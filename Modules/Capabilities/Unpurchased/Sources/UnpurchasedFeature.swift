//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Foundation

public struct UnpurchasedFeature {
    public static let autoRedactions = UnpurchasedFeature(
        message: Strings.AutoRedactions.message,
        learnMoreAction: nil,
        hideFeatureKey: .hideAutoRedactions
    )

    public static func documentScanner(learnMoreAction: (() -> Void)?) -> UnpurchasedFeature {
        UnpurchasedFeature(
            message: Strings.DocumentScanner.message,
            learnMoreAction: learnMoreAction,
            hideFeatureKey: .hideDocumentScanner
        )
    }

    // MARK: - Implementation Details

    let message: String
    let learnMoreAction: (() -> Void)?
    let hideFeatureKey: Defaults.Key?

    private init(message: String, learnMoreAction: ( () -> Void)?, hideFeatureKey: Defaults.Key?) {
        self.message = message
        self.learnMoreAction = learnMoreAction
        self.hideFeatureKey = hideFeatureKey
    }

    private typealias Strings = UnpurchasedStrings.UnpurchasedFeature
}
