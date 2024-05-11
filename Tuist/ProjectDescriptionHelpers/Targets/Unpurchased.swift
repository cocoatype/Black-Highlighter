import ProjectDescription

public enum Unpurchased {
    public static let target = Target.capabilitiesTarget(name: "Unpurchased", hasResources: true, dependencies: [
        .target(Defaults.target),
    ])
}
