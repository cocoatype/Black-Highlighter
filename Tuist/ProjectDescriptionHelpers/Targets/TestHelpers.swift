import ProjectDescription

public enum TestHelpers {
    public static let target = Target.target(
        name: "TestHelpers",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.TestHelpers",
        sources: ["Modules/TestHelpers/Sources/**"],
        headers: .headers(public: ["Modules/TestHelpers/Headers/**"]),
        dependencies: [
            .target(interfaceTarget),
            .xctest
        ]
    )

    public static let interfaceTarget = Target.target(
        name: "TestHelpersInterface",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.TestHelpersInterface",
        sources: ["Modules/TestHelpers/Interface/**"]
    )
}
