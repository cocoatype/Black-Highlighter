import ProjectDescription

public enum Unpurchased {
    public static let target = Target.capabilitiesTarget(
        name: "Unpurchased",
        hasResources: true,
        dependencies: [
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Logging.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Unpurchased",
        dependencies: [
            .target(DesignSystem.target),
            .target(Logging.doublesTarget),
        ]
    )
}
