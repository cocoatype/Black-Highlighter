//  Created by Geoff Pado on 6/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Redactions

@available(iOS 16, *)
struct OpenImageIntent: AppIntent, OpenIntent {
    static let title: LocalizedStringResource = "OpenImageIntent.title"

    static let description: IntentDescription = "OpenImageIntent.description"

    @Parameter(
        title: "OpenImageIntent.sourceImage.title",
        supportedTypeIdentifiers: ["public.image"],
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var sourceImage: IntentFile

    let redactions: [Redaction]?

    var target: some AppValue {
        sourceImage
    }

    init() {
        self.redactions = nil
    }

    init(sourceImage: IntentFile, redactions: [Redaction]) {
        self.redactions = redactions
        self.sourceImage = sourceImage
    }

//    static var parameterSummary: some ParameterSummary {
//        Summary("OpenIntent.parameterSummary\(\.sourceImages)")
//    }

    func perform() async throws -> some IntentResult {
        // open file here ???
        return .result()
    }
}
