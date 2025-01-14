import ProjectDescription

public enum Core {
    public static let target = Target.target(
        name: "Core",
        destinations: SDK.catalyst.destinations,
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Core",
        sources: ["Modules/Legacy/Core/Sources/**"],
        resources: ["Modules/Legacy/Core/Resources/**"],
        headers: .headers(public: ["Modules/Legacy/Core/Headers/**"]),
        dependencies: [
            .target(AlbumsUI.target),
            .target(AppNavigation.target),
            .target(AppRatings.target),
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Detections.target(sdk: .catalyst)),
            .target(Editing.target),
            .target(PurchaseMarketing.target),
            .target(Purchasing.target),
            .target(Purchasing.doublesTarget),
            .target(Scenes.target),
            .target(SettingsUI.target),
            .target(Tools.target),
            .target(Unpurchased.target),
            .target(URLParsing.target),
            .target(UserActivities.target),
        ],
        settings: .settings(
            base: [
                "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": false,
            ],
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
                "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER",
            ])
        )
    )

    public static let testTarget = Target.moduleTestTarget(
        name: "Core",
        sdk: .catalyst,
        type: "Legacy",
        dependencies: [
            .target(DesignSystem.doublesTarget),
            .target(Logging.doublesTarget),
            .target(Purchasing.doublesTarget),
        ]
    )
}
