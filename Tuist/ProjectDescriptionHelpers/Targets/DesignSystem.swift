import ProjectDescription

public enum DesignSystem {
    public static let target = Target.capabilitiesTarget(name: "DesignSystem", hasResources: true, dependencies: [
        .target(ErrorHandling.target),
    ])
}
