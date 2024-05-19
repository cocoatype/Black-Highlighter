import ProjectDescription

public enum ErrorHandling {
    public static let target = Target.capabilitiesTarget(
        name: "ErrorHandling",
        dependencies: [
            .target(Logging.target),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "ErrorHandling",
        dependencies: [
            .target(Logging.doublesTarget),
        ]
    )
}
