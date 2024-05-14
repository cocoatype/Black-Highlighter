import ProjectDescription

public enum Redactions {
    public static func target(sdk: SDK = .catalyst) -> Target {
        Target.capabilitiesTarget(name: "Redactions", sdk: sdk, dependencies: [
            .target(Observations.target(sdk: sdk)),
        ])
    }

    public static let testTarget = Target.capabilitiesTestTarget(name: "Redactions", dependencies: [
        .target(Observations.target(sdk: .catalyst)),
        .target(TestHelpers.target),
    ])
}
