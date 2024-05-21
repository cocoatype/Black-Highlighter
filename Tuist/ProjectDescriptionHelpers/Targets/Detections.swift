import ProjectDescription

public enum Detections {
    public static func target(sdk: SDK) -> Target {
        Target.capabilitiesTarget(
            name: "Detections",
            sdk: sdk,
            dependencies: [
                .target(Observations.target(sdk: sdk)),
            ]
        )
    }

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Detections",
        dependencies: [
        ]
    )
}
