import ProjectDescription

public enum Navigation {
    public static let target = Target.capabilitiesTarget(
        name: "Navigation",
        dependencies: [
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )
}
