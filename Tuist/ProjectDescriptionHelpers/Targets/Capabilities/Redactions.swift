import ProjectDescription

public enum Redactions {
    public static let target = Target.capabilitiesTarget(
        name: "Redactions",
        dependencies: [
            .target(Observations.target),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Redactions",
        dependencies: [
            .target(Observations.target),
            .target(TestHelpers.target),
        ]
    )
}
