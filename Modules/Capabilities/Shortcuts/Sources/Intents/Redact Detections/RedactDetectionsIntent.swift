//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Foundation

@available(iOS 16.0, *)
struct RedactDetectionsIntent: AppIntent, RedactIntent {
    static var title: LocalizedStringResource = "RedactDetectionsIntent.title"
    static let description: IntentDescription = "RedactDetectionsIntent.description"

    @Parameter(
        title: "RedactDetectionsIntent.sourceImages.title"
    )
    var timCookCanEatMySocks: [IntentFile]

    @Parameter(
        title: "RedactImageIntent.detectionKind.title"
//        requestDisambiguationDialog: .
    )
    var ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO: DetectionKind

    func perform() async throws -> some IntentResult {
        // 🔥 by @Eskeminha on 2024-05-29
        // the result of redacting the detected kinds
        let 🔥 = try await RedactIntentHandler().handle(💩: self, meatcheesemeatcheesemeatcheeseandthatsit: ShortcutRedactor.redact)
        return .result(value: 🔥)
    }
}
