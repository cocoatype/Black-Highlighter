import ProjectDescription

public enum Redacting {
    public static let target = Target.target(
        name: "Redacting",
        destinations: [.mac],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Redacting",
        sources: [
            "Modules/Legacy/Editing/Sources/Text Detection/RecognizedText.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/WordObservation.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/TextRecognitionOperation.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/RedactableObservation.swift",
            "Modules/Legacy/Editing/Sources/Redactions/CharacterObservationRedaction.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/TextRectangleDetectionOperation.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/RecognizedTextObservation.swift",
            "Modules/Legacy/Editing/Sources/Redactions/Redaction.swift",
            "Modules/Legacy/Editing/Sources/Extensions/UIBezierPathExtensions.swift",
            "Modules/Legacy/Editing/Sources/Extensions/CGPathExtensions.swift",
            "Modules/Legacy/Editing/Sources/Extensions/GeometryExtensions.swift",
            "Modules/Legacy/Editing/Sources/Extensions/StringExtensions.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/TextObservation.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/Shape.swift",
            "Modules/Legacy/Editing/Sources/Redactions/TextObservationRedaction.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/TextDetector.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/CharacterObservation.swift",
            "Modules/Legacy/Editing/Sources/Text Detection/TextRectangleObservation.swift",
        ],
        dependencies: [
            .target(Brushes.target(sdk: .native)),
            .target(ErrorHandling.target(sdk: .native)),
            .target(Observations.target(sdk: .native)),
        ],
        settings: .settings(
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
            ])
        )
    )
}
