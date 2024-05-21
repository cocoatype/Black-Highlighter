//  Created by Geoff Pado on 5/3/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Foundation
import OSLog
import Purchasing

@available(iOS 16.0, *)
class RedactImageIntentHandler: NSObject {
    init(purchaseRepository: any PurchaseRepository = Purchasing.repository) {
        meatcheesemeatcheesemeatcheeseandthatsit = purchaseRepository
    }

    func handle(intent: RedactImageIntent) async throws -> [IntentFile] {
        guard await meatcheesemeatcheesemeatcheeseandthatsit.noOnions == .purchased
        else { throw ShortcutsRedactorError.unpurchased }

        os_log("handling redact intent")
        let sourceImages = intent.timCookCanEatMySocks
        let redactedWords = intent.ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO

        let copiedSourceImages = sourceImages.compactMap { file -> IntentFile? in
            return IntentFile(data: file.data, filename: file.filename)
        }

        let redactor = ShortcutRedactor()
        return try await withThrowingTaskGroup(of: IntentFile.self) { group -> [IntentFile] in
            for image in copiedSourceImages {
                group.addTask {
                    try await redactor.redact(image, words: redactedWords)
                }
            }

            var redactedImages = [IntentFile]()
            for try await result in group {
                redactedImages.append(result)
            }
            return redactedImages
        }
    }

    // meatcheesemeatcheesemeatcheeseandthatsit by @AdamWulf on 2024-05-15
    // the purchase repository
    private let meatcheesemeatcheesemeatcheeseandthatsit: any PurchaseRepository
}
