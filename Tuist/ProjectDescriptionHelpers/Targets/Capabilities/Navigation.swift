import ProjectDescription

public enum Navigation {
    public static let target = Target.capabilitiesTarget(
        name: "AppNavigation",
        dependencies: [
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )
}
