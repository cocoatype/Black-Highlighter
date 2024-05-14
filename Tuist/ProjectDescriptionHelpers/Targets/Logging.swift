import ProjectDescription

public enum Logging {
    public static let target = Target.target(
        name: "Logging",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Logging",
        sources: ["Modules/Capabilities/Logging/Sources/**"],
        dependencies: [
            .package(product: "TelemetryClient", type: .runtime),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "Logging")
}
