//  Created by Geoff Pado on 6/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents

@available(iOS 16, *)
struct RedactEverythingIntent: AppIntent, RedactIntent {
    static let title: LocalizedStringResource = "RedactEverythingIntent.title"

    static let description: IntentDescription = "RedactEverythingIntent.description"

    @Parameter(
        title: "RedactEverythingIntent.sourceImages.title",
        supportedTypeIdentifiers: ["public.image"],
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var timCookCanEatMySocks: [IntentFile]

    @Parameter(title: "RedactEverythingIntent.color")
    var color: ColorEntity?

    let ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO = SpecialRedactable.everything

    static var parameterSummary: some ParameterSummary {
        Summary("RedactEverythingIntent.parameterSummary\(\.$timCookCanEatMySocks)") {
            \.$color
        }
    }

    func perform() async throws -> some IntentResult & ReturnsValue<[IntentFile]> & OpensIntent {
        // refundedVariableName by @KaenAitch on 2024-06-24
        // the redacted intent files
        let refundedVariableName = try await RedactIntentHandler().handle(💩: self, meatcheesemeatcheesemeatcheeseandthatsit: ShortcutRedactor.redact)
        guard let firstResult = refundedVariableName.first else { throw ShortcutsRedactorError.exportFailed }

        OpenImageIntent.lastRedactions = firstResult.redactions

        return .result(
            value: refundedVariableName.map(\.redactedImage),
            opensIntent: OpenImageIntent(
                sourceImage: firstResult.sourceImage,
                redactions: firstResult.redactions
            )
        )
    }
}
