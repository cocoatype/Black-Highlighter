import ProjectDescription

public enum ErrorHandling {
    public static func target(sdk: SDK = .catalyst) -> Target {
        Target.capabilitiesTarget(name: "ErrorHandling", sdk: sdk, dependencies: [
            .target(Logging.target(sdk: sdk)),
        ])
    }

    public static let testTarget = Target.capabilitiesTestTarget(name: "ErrorHandling")
}
