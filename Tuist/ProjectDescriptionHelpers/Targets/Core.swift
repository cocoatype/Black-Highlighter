import ProjectDescription

public enum Core {
    public static let target = Target.target(
        name: "Core",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Core",
        sources: ["Modules/Legacy/Core/Sources/**"],
        headers: .headers(public: ["Modules/Legacy/Core/Headers/**"]),
        dependencies: [
            .target(AppRatings.target),
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Detections.target),
            .target(Editing.target),
            .target(PurchaseMarketing.target),
            .target(Purchasing.target),
            .target(Receipts.target),
            .target(Unpurchased.target),
        ]
    )

    public static let testTarget = Target.moduleTestTarget(name: "Core", type: "Legacy")
}
