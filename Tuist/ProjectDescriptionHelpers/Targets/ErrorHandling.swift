import ProjectDescription

public enum ErrorHandling {
    public static let target = Target.target(
        name: "ErrorHandling",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.ErrorHandling",
        sources: ["Modules/Capabilities/ErrorHandling/Sources/**"],
        dependencies: [
            .target(Logging.target),
        ]
    )

    public static let testTarget = Target.moduleTestTarget(name: "ErrorHandling")
}
