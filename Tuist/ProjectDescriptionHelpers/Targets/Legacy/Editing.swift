import ProjectDescription

public enum Editing {
    public static let target = Target.target(
        name: "Editing",
        destinations: SDK.catalyst.destinations,
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Editing",
        sources: ["Modules/Legacy/Editing/Sources/**"],
        headers: .headers(public: ["Modules/Legacy/Editing/Headers/**"]),
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(Brushes.target(sdk: .catalyst)),
            .target(DebugOverlay.target),
            .target(Detections.target(sdk: .catalyst)),
            .target(ErrorHandling.target(sdk: .catalyst)),
            .target(Exporting.target(sdk: .catalyst)),
            .target(Observations.target(sdk: .catalyst)),
            .target(PurchaseMarketing.target),
            .target(Purchasing.doublesTarget),
            .target(Redactions.target(sdk: .catalyst)),
            .target(Unpurchased.target),
            .external(name: "ClippingBezier"),
        ],
        settings: .settings(
            base: [
                "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "",
            ],
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
            ])
        )
    )

    public static let testTarget = Target.moduleTestTarget(
        name: "Editing",
        sdk: .catalyst,
        type: "Legacy",
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(Purchasing.doublesTarget),
        ]
    )
}
