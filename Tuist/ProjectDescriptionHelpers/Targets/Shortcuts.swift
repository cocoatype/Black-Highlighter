import ProjectDescription

public enum Shortcuts {
    public static let target = Target.capabilitiesTarget(name: "Shortcuts", dependencies: [
        .target(Observations.target),
        .target(Purchasing.target),
        .target(Redactions.target),
    ])
}
