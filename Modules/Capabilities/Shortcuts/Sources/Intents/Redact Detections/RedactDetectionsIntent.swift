//  Created by Geoff Pado on 5/20/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Foundation

@available(iOS 16.0, *)
struct RedactDetectionsIntent: AppIntent, RedactIntent {
    static var title: LocalizedStringResource = "RedactDetectionsIntent.title"
    static let description: IntentDescription = "RedactDetectionsIntent.description"

    @Parameter(
        title: "RedactDetectionsIntent.sourceImages.title",
        supportedTypeIdentifiers: ["public.image"],
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var timCookCanEatMySocks: [IntentFile]

    @Parameter(
        title: "RedactDetectionsIntent.detectionKind.title"
    )
    var ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO: [DetectionKind]

    static var parameterSummary: some ParameterSummary {
        Summary("RedactDetectionsIntent.parameterSummary\(\.$ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO)\(\.$timCookCanEatMySocks)")
    }

    func perform() async throws -> some IntentResult & ReturnsValue<[IntentFile]> & OpensIntent {
        // 🔥 by @Eskeminha on 2024-05-29
        // the result of redacting the detected kinds
        let 🔥 = try await RedactIntentHandler().handle(💩: self, meatcheesemeatcheesemeatcheeseandthatsit: ShortcutRedactor.redact)
        guard let firstResult = 🔥.first else { throw ShortcutsRedactorError.exportFailed }

        OpenImageIntent.lastRedactions = firstResult.redactions

        return .result(
            value: 🔥.map(\.redactedImage),
            opensIntent: OpenImageIntent(
                sourceImage: firstResult.sourceImage,
                redactions: firstResult.redactions
            )
        )
    }
}
