import ProjectDescription

public enum PurchaseMarketing {
    public static let target = Target.capabilitiesTarget(
        name: "PurchaseMarketing",
        hasResources: true,
        dependencies: [
            .target(DesignSystem.target),
            .target(Logging.target(sdk: .catalyst)),
            .target(Purchasing.target),
            .target(Purchasing.doublesTarget),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "PurchaseMarketing",
        dependencies: [
            .target(Logging.doublesTarget),
        ]
    )
}
