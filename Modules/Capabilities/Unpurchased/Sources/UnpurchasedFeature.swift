//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Foundation

public struct UnpurchasedFeature {
    public typealias LearnMoreAction = () -> Void

    public static func autoRedactions(learnMoreAction: LearnMoreAction? = nil) -> UnpurchasedFeature {
        UnpurchasedFeature(
            message: Strings.AutoRedactions.message,
            learnMoreAction: learnMoreAction,
            hideFeatureKey: .hideAutoRedactions
        )
    }

    public static func documentScanner(learnMoreAction: LearnMoreAction?) -> UnpurchasedFeature {
        UnpurchasedFeature(
            message: Strings.DocumentScanner.message,
            learnMoreAction: learnMoreAction,
            hideFeatureKey: .hideDocumentScanner
        )
    }

    // MARK: - Implementation Details

    let message: String
    let learnMoreAction: LearnMoreAction?
    let hideFeatureKey: Defaults.Key?

    init(message: String, learnMoreAction: LearnMoreAction?, hideFeatureKey: Defaults.Key?) {
        self.message = message
        self.learnMoreAction = learnMoreAction
        self.hideFeatureKey = hideFeatureKey
    }

    private typealias Strings = UnpurchasedStrings.UnpurchasedFeature
}
