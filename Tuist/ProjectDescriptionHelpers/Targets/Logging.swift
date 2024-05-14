import ProjectDescription

public enum Logging {
    public static func target(sdk: SDK) -> Target {
        Target.capabilitiesTarget(name: "Logging", sdk: sdk, dependencies: [
            .package(product: "TelemetryClient", type: .runtime),
        ])
    }

    public static let testTarget = Target.capabilitiesTestTarget(name: "Logging")
}
