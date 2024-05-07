import ProjectDescription

extension Target {
    static func moduleTestTarget(name: String, type: String = "Capabilities", dependencies: [ProjectDescription.TargetDependency] = []) -> Target {
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
