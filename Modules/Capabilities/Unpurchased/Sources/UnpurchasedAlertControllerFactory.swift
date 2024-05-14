//  Created by Geoff Pado on 2/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Defaults
import DesignSystem
import UIKit

public class UnpurchasedAlertControllerFactory {
    public init() {}

    public func alertController(for feature: UnpurchasedFeature) -> UIAlertController {
        let alertController = UIAlertController(
            title: Strings.title,
            message: feature.message,
            preferredStyle: .alert
        )

        alertController.view.tintColor = .controlTint

        if let learnMoreAction = feature.learnMoreAction {
            alertController.addAction(
                UIAlertAction(
                    title: Strings.learnMoreButton,
                    style: .default,
                    handler: { _ in
                        learnMoreAction()
                    }
                )
            )
        }

        if let hideFeatureKey = feature.hideFeatureKey {
            @Defaults.Value(key: hideFeatureKey) var hideFeature: Bool
            alertController.addAction(
                UIAlertAction(
                    title: Strings.hideButton,
                    style: .default,
                    handler: { _ in
                        hideFeature = true
                    }
                )
            )
        }

        alertController.addAction(
            UIAlertAction(
                title: Strings.dismissButton,
                style: .cancel,
                handler: { _ in }
            )
        )

        return alertController
    }

    private typealias Strings = UnpurchasedStrings.UnpurchasedAlert
}
