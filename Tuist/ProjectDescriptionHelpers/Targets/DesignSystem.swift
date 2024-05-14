import ProjectDescription

public enum DesignSystem {
    public static let target = Target.capabilitiesTarget(name: "DesignSystem", dependencies: [
        .target(ErrorHandling.target()),
    ])
}
