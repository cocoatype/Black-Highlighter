import ProjectDescription

extension Target {
    static func capabilitiesTarget(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
            product: .framework,
            bundleId: "com.cocoatype.Highlighter.\(name)",
            sources: ["Modules/Capabilities/\(name)/Sources/**"],
            dependencies: dependencies
        )
    }

    static func capabilitiesTestTarget(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        moduleTestTarget(name: name, type: "Capabilities", dependencies: [])
    }

    static func moduleTestTarget(name: String, type: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
            product: .unitTests,
            bundleId: "com.cocoatype.Highlighter.\(name)Tests",
            sources: ["Modules/\(type)/\(name)/Tests/**"],
            dependencies: [.target(name: name)] + dependencies
        )
    }
}
