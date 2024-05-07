import ProjectDescription

public enum DesignSystem {
    public static let target = Target.target(
        name: "DesignSystem",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.DesignSystem",
        sources: ["Modules/Capabilities/DesignSystem/Sources/**"],
        dependencies: [
            .target(ErrorHandling.target)
        ]
    )
}
