import ProjectDescription

public enum PurchaseMarketing {
    public static let target = Target.capabilitiesTarget(
        name: "PurchaseMarketing",
        dependencies: [
            .target(DesignSystem.target),
            .target(Purchasing.target),
            .target(Purchasing.doublesTarget),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "PurchaseMarketing")
}