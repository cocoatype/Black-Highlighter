import ProjectDescription

public enum Exporting {
    public static func target(sdk: SDK) -> Target {
        Target.capabilitiesTarget(
            name: "Exporting",
            sdk: sdk,
            dependencies: [
                .target(Brushes.target(sdk: sdk)),
                .target(Geometry.target(sdk: sdk)),
            ]
        )
    }

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Exporting",
        dependencies: [
        ]
    )
}
