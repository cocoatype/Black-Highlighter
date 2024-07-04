import ProjectDescription

public enum AppNavigation {
    public static let target = Target.capabilitiesTarget(
        name: "AppNavigation",
        dependencies: [
            .target(AlbumsData.target),
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )
}
