import ProjectDescription

public enum Shortcuts {
    public static let target = Target.capabilitiesTarget(
        name: "Shortcuts",
        dependencies: [
            .target(Exporting.target),
            .target(Observations.target(sdk: .catalyst)),
            .target(Purchasing.target),
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "Shortcuts",
        dependencies: [
            .target(Detections.target(sdk: .catalyst)),
            .target(Observations.target(sdk: .catalyst)),
            .target(Redactions.target(sdk: .catalyst)),
        ]
    )
}
