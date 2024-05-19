import ProjectDescription

public enum Core {
    public static let target = Target.target(
        name: "Core",
        destinations: SDK.catalyst.destinations,
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Core",
        sources: ["Modules/Legacy/Core/Sources/**"],
        headers: .headers(public: ["Modules/Legacy/Core/Headers/**"]),
        dependencies: [
            .target(AppRatings.target),
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Detections.target(sdk:.catalyst)),
            .target(Editing.target),
            .target(PurchaseMarketing.target),
            .target(Purchasing.target),
            .target(Purchasing.doublesTarget),
            .target(Unpurchased.target),
        ],
        settings: .settings(
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
            ])
        )
    )

    public static let testTarget = Target.moduleTestTarget(
        name: "Core",
        sdk: .catalyst,
        type: "Legacy",
        dependencies: [
            .target(Logging.doublesTarget),
            .target(Purchasing.doublesTarget),
        ]
    )
}
