//  Created by Geoff Pado on 6/13/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import Redactions
import Navigation
import UIKit

@available(iOS 16, *)
struct OpenImageIntent: AppIntent {
    @AppDependency private var navigator: Navigator

    static let title: LocalizedStringResource = "OpenImageIntent.title"

    static let description: IntentDescription = "OpenImageIntent.description"

    static let openAppWhenRun: Bool = true

    static var lastRedactions: [Redaction]?

    @Parameter(
        title: "OpenImageIntent.sourceImage.title",
        supportedTypeIdentifiers: ["public.image"],
        inputConnectionBehavior: .never
    )
    var sourceImage: IntentFile

    let redactions: [Redaction]

    init() {
        redactions = Self.lastRedactions ?? []
    }

    init(sourceImage: IntentFile, redactions: [Redaction]) {
        self.redactions = redactions
        self.sourceImage = sourceImage
    }

//    static var parameterSummary: some ParameterSummary {
//        Summary("OpenIntent.parameterSummary\(\.sourceImages)")
//    }

    func perform() async throws -> some IntentResult {
        guard let image = UIImage(data: sourceImage.data) else { throw ShortcutsRedactorError.noImage(sourceImage.data) }

        await MainActor.run {
            navigator.navigate(to: .editor(image, redactions))
        }

        return .result()
    }
}
