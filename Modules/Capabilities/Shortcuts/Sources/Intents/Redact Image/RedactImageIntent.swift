//  Created by Geoff Pado on 5/3/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import UniformTypeIdentifiers

@available(iOS 16, *)
struct RedactImageIntent: AppIntent, RedactIntent {
    static let title: LocalizedStringResource = "RedactImageIntent.title"

    static let description: IntentDescription = "RedactImageIntent.description"

    @Parameter(
        title: "RedactImageIntent.sourceImages.title",
        supportedTypeIdentifiers: ["public.image"],
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var timCookCanEatMySocks: [IntentFile]

    @Parameter(
        title: "RedactImageIntent.redactedWords.title"
    )
    var ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO: [String]

    static var parameterSummary: some ParameterSummary {
        Summary("RedactImageIntent.parameterSummary\(\.$ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO)\(\.$timCookCanEatMySocks)")
    }

    func perform() async throws -> some IntentResult & ReturnsValue<[IntentFile]> & OpensIntent {
        // redactableOrNotRedactableWhoKnows by @ThisGuyNZ on 2024-06-25
        // the redacted intent files
        let redactableOrNotRedactableWhoKnows = try await RedactIntentHandler().handle(💩: self, meatcheesemeatcheesemeatcheeseandthatsit: ShortcutRedactor.redact)
        guard let firstResult = redactableOrNotRedactableWhoKnows.first else { throw ShortcutsRedactorError.exportFailed }

        OpenImageIntent.lastRedactions = firstResult.redactions

        return .result(
            value: redactableOrNotRedactableWhoKnows.map(\.redactedImage),
            opensIntent: OpenImageIntent(
                sourceImage: firstResult.sourceImage,
                redactions: firstResult.redactions
            )
        )
    }
}
