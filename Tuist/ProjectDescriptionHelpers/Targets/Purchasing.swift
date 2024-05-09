import ProjectDescription

public enum Purchasing {
    public static let target = Target.capabilitiesTarget(name: "Purchasing", dependencies: [
        .target(ErrorHandling.target),
        .target(Receipts.target),
    ])

    public static let testTarget = Target.capabilitiesTestTarget(name: "Purchasing")
}
