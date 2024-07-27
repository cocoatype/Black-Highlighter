import ProjectDescription

public enum Scenes {
    public static let target = Target.capabilitiesTarget(
        name: "Scenes",
        usesMaxSwiftVersion: true,
        dependencies: [
            .target(UserActivities.target),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Scenes",
        dependencies: [
        ]
    )
}
