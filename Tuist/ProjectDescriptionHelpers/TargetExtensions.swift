import ProjectDescription

extension Target {
    static func capabilitiesTarget(
        name: String,
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
            product: .framework,
            bundleId: "com.cocoatype.Highlighter.\(name)",
            sources: ["Modules/Capabilities/\(name)/Sources/**"],
            resources: hasResources ? ["Modules/Capabilities/\(name)/Resources/**"] : nil,
            dependencies: dependencies
        )
    }

    static func capabilitiesTestTarget(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        moduleTestTarget(name: name, type: "Capabilities", dependencies: dependencies)
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

    static func capabilitiesDoublesTarget(name: String) -> Target {
        return Target.target(
            name: "\(name)Doubles",
            destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign, .mac],
            product: .framework,
            bundleId: "com.cocoatype.Highlighter.\(name)Doubles",
            sources: ["Modules/Capabilities/\(name)/Doubles/**"],
            dependencies: [.target(name: name), .target(TestHelpers.interfaceTarget)]
        )
    }
}
