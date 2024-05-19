import ProjectDescription

public enum Observations {
    public static func target(sdk: SDK) -> Target {
        Target.capabilitiesTarget(
            name: "Observations",
            sdk: sdk
        )
    }

    public static let testTarget = Target.capabilitiesTestTarget(name: "Observations")
}
