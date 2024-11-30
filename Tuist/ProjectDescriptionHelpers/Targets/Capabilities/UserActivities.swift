import ProjectDescription

public enum UserActivities {
    public static let target = Target.capabilitiesTarget(
        name: "UserActivities",
        hasResources: true,
        usesMaxSwiftVersion: true,
        dependencies: [
            .target(AlbumsData.target),
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "UserActivities",
        dependencies: [
        ]
    )
}
