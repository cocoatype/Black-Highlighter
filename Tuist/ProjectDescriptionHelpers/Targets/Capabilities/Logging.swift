import ProjectDescription

public enum Logging {
    public static func target(sdk: SDK) -> Target {
        Target.capabilitiesTarget(
            name: "Logging",
            sdk: sdk,
            dependencies: [
                .external(name: "TelemetryClient"),
            ]
        )
    }

    public static let testTarget = Target.capabilitiesTestTarget(name: "Logging")

    public static let doublesTarget = Target.capabilitiesDoublesTarget(name: "Logging")
}
