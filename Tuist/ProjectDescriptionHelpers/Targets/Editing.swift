import ProjectDescription

public enum Editing {
    public static let target = Target.target(
        name: "Editing",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Editing",
        sources: ["Modules/Legacy/Editing/Sources/**"],
        resources: ["Modules/Legacy/Editing/Resources/**"],
        headers: .headers(public: ["Modules/Legacy/Editing/Headers/**"]),
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(ErrorHandling.target),
            .target(Observations.target),
            .target(Redactions.target),
            .package(product: "ClippingBezier", type: .runtime),
            .package(product: "Introspect", type: .runtime),
        ],
        settings: .settings(
            base: [
                "ASSETCATALOG_COMPILER_APPICON_NAME": "",
                "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "",
            ]
        )
    )

    public static let testTarget = Target.moduleTestTarget(name: "Editing", type: "Legacy")
}
