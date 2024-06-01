import ProjectDescription

public enum AutoRedactionsUI {
    public static let target = Target.capabilitiesTarget(
        name: "AutoRedactionsUI",
        hasResources: true,
        dependencies: [
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Detections.target(sdk: .catalyst)),
            .target(ErrorHandling.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "AutoRedactionsUI")
}
