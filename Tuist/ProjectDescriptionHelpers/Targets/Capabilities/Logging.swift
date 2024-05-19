import ProjectDescription

public enum Logging {
    public static let target = Target.capabilitiesTarget(
        name: "Logging",
        dependencies: [
            .package(product: "TelemetryClient", type: .runtime),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "Logging")

    public static let doublesTarget = Target.capabilitiesDoublesTarget(name: "Logging")
}
