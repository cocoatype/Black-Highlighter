import ProjectDescription

public enum AppRatings {
    public static let target = Target.target(
        name: "AppRatings",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.AppRatings",
        sources: ["Modules/Capabilities/AppRatings/Sources/**"],
        dependencies: [
            .target(ErrorHandling.target),
        ]
    )

    public static let testTarget = Target.moduleTestTarget(name: "AppRatings", dependencies: [
        .target(TestHelpers.target),
    ])
}
