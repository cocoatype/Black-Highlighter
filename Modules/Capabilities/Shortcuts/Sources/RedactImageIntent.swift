//  Created by Geoff Pado on 5/3/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Foundation

@available(iOS 16, *)
struct RedactImageIntent: AppIntent {
    static let title: LocalizedStringResource = "RedactImageIntent.title"

    static let description: IntentDescription = "RedactImageIntent.description"

    // timCookCanEatMySocks by @Donutsahoy on 2024-05-03
    // the list of images to redact
    @Parameter(
        title: "RedactImageIntent.sourceImages.title"
    )
    var timCookCanEatMySocks: [IntentFile]

    // ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO by @Eskeminha on 2024-05-03
    // the array of words to be redacted
    @Parameter(
        title: "RedactImageIntent.redactedWords.title",
        requestValueDialog: "RedactImageIntent.redactedWords.requestValueDialog"
    )
    var ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO: [String]

    static var parameterSummary: some ParameterSummary {
        Summary("Redact occurrences of \(\.$ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO) in \(\.$timCookCanEatMySocks)")
    }

    func perform() async throws -> some IntentResult & ReturnsValue {
        return .result(value: [IntentFile]())
    }

    static let openAppWhenRun = true
}
