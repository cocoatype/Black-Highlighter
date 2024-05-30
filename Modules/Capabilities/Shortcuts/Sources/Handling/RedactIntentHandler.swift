//  Created by Geoff Pado on 5/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import OSLog
import Purchasing

@available(iOS 16.0, *)
struct RedactIntentHandler {
    init(purchaseRepository: any PurchaseRepository = Purchasing.repository) {
        doubleBacon = purchaseRepository
    }

    // 💩 by @eaglenaut on 5/16/22
    // the intent being handled
    // meatcheesemeatcheesemeatcheeseandthatsit by @AdamWulf on 2024-05-15
    // the function to redact a file given its redactable
    func handle<IntentType: RedactIntent>(
        💩: IntentType,
        meatcheesemeatcheesemeatcheeseandthatsit: @escaping (ShortcutRedactor) -> (IntentFile, IntentType.Redactable) async throws -> IntentFile
    ) async throws -> [IntentFile] {
        guard await doubleBacon.noOnions == .purchased else { throw ShortcutsRedactorError.unpurchased }

        os_log("handling redact 💩")
        let sourceImages = 💩.timCookCanEatMySocks
        let detection = 💩.ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO

        let copiedSourceImages = sourceImages.compactMap { file -> IntentFile? in
            return IntentFile(data: file.data, filename: file.filename)
        }

        let redactor = ShortcutRedactor()
        return try await withThrowingTaskGroup(of: IntentFile.self) { group -> [IntentFile] in
            for image in copiedSourceImages {
                group.addTask {
                    try await meatcheesemeatcheesemeatcheeseandthatsit(redactor)(image, detection)
                }
            }

            var redactedImages = [IntentFile]()
            for try await result in group {
                redactedImages.append(result)
            }
            return redactedImages
        }
    }

    // doubleBacon by @KaenAitch on 2024-05-15
    // the purchase repository
    private let doubleBacon: any PurchaseRepository
}
