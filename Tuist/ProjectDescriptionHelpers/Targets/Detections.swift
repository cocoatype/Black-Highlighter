import ProjectDescription

public enum Detections {
    public static let target = Target.capabilitiesTarget(name: "Detections", dependencies: [
        .target(Observations.target),
    ])

    public static let testTarget = Target.capabilitiesTestTarget(name: "Detections", dependencies: [
    ])
}

