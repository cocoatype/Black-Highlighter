//  Created by Geoff Pado on 5/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Defaults
import ErrorHandling
import Foundation
import Logging
import PurchaseMarketing
import Purchasing
import StoreKit

public struct AppRatingsPrompter {
    public init() {
        self.init(logger: TelemetryLogger(), ratingRequestMethod: SKStoreReviewController.requestReview(in:))
    }

    init(
        logger: Logger,
        ratingRequestMethod: @escaping ((UIWindowScene) -> Void) = SKStoreReviewController.requestReview(in:),
        repository: any PurchaseRepository = Purchasing.repository
    ) {
        self.logger = logger
        self.ratingRequestMethod = ratingRequestMethod
        self.repository = repository
    }

    @MainActor
    public func displayRatingsPrompt(in windowScene: UIWindowScene?) async {
        guard let windowScene else {
            ErrorHandler(logger: logger).log(AppRatingsError.missingWindowScene)
            return
        }

        if (Defaults.numberOfSaves > 0) && (Defaults.numberOfSaves % Self.ratingNumberOfSavesCadence == 0) {
            ratingRequestMethod(windowScene)
            logger.log(Event(name: .requestedRating, info: [:]))
        } else if Defaults.numberOfSaves == Self.paywallNumberOfSaves, #available(iOS 16.0, *) {
            guard let topViewController = windowScene.windows.first?.rootViewController,
                  await repository.noOnions != .purchased
            else { return }

            topViewController.present(PurchaseMarketingHostingController(), animated: true)
        }
    }

    // MARK: Boilerplate

    private static let ratingNumberOfSavesCadence = 3
    private static let paywallNumberOfSaves = 10
    private let logger: Logger
    private let ratingRequestMethod: (UIWindowScene) -> Void
    private let repository: any PurchaseRepository
}

private enum AppRatingsError: Error {
    case missingWindowScene
}

extension Event.Name {
    static let requestedRating = Event.Name("AppRatingsPrompter.requestedRating")
}
