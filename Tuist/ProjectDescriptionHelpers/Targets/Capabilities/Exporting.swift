import ProjectDescription

public enum Exporting {
    public static var target = Target.capabilitiesTarget(
        name: "Exporting",
        dependencies: [
            .target(Brushes.target(sdk: .catalyst)),
            .target(DesignSystem.target),
            .target(Geometry.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Exporting",
        dependencies: [
        ]
    )
}
