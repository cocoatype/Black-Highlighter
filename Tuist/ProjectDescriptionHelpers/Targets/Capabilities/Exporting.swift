import ProjectDescription

public enum Exporting {
    public static let target = Target.capabilitiesTarget(
        name: "Exporting",
        hasResources: true,
        dependencies: [
            .target(DesignSystem.target),
            .target(Redactions.target(sdk: .catalyst)),
            .target(Rendering.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Exporting",
        dependencies: [
        ]
    )
}
