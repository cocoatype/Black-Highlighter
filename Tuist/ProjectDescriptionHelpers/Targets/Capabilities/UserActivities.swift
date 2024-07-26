import ProjectDescription

public enum UserActivities {
    public static let target = Target.capabilitiesTarget(
        name: "UserActivities",
        usesMaxSwiftVersion: true,
        dependencies: [
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "UserActivities",
        dependencies: [
        ]
    )
}
