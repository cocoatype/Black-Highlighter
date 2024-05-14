import ProjectDescription

public enum AutoRedactionsUI {
    public static let target = Target.capabilitiesTarget(name: "AutoRedactionsUI", dependencies: [
        .target(DesignSystem.target),
        .target(ErrorHandling.target()),
    ])

    public static let testTarget = Target.capabilitiesTestTarget(name: "AutoRedactionsUI")
}
