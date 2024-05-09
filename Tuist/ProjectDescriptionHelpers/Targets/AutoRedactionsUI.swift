import ProjectDescription

public enum AutoRedactionsUI {
    public static let target = Target.target(
        name: "AutoRedactionsUI",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.AutoRedactionsUI",
        sources: ["Modules/Capabilities/AutoRedactionsUI/Sources/**"],
        dependencies: [
            .target(DesignSystem.target),
            .target(ErrorHandling.target),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "AutoRedactionsUI")
}
