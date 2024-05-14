import ProjectDescription

public enum AppRatings {
    public static let target = Target.capabilitiesTarget(name: "AppRatings", dependencies: [
        .target(Defaults.target),
        .target(ErrorHandling.target()),
    ])

    public static let testTarget = Target.capabilitiesTestTarget(name: "AppRatings", dependencies: [
        .target(Defaults.target),
        .target(Editing.target),
        .target(TestHelpers.target),
    ])
}
