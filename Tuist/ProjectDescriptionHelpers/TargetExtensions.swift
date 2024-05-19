import ProjectDescription

extension Target {
    static func capabilitiesTarget(
        name: String,
        sdk: SDK = .catalyst,
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name + sdk.nameSuffix,
            destinations: sdk.destinations,
            product: .framework,
            bundleId: "com.cocoatype.Highlighter.\(name)",
            sources: ["Modules/Capabilities/\(name)/Sources/**"],
            resources: hasResources ? ["Modules/Capabilities/\(name)/Resources/**"] : nil,
            dependencies: dependencies,
            settings: .settings(
                base: [
                    "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": false,
                ],
                defaultSettings: .none
            )
        )
    }

    static func capabilitiesTestTarget(
        name: String,
        sdk: SDK = .catalyst,
        dependencies: [TargetDependency] = []
    ) -> Target {
        moduleTestTarget(
            name: name,
            sdk: sdk,
            type: "Capabilities",
            dependencies: dependencies
        )
    }

    static func moduleTestTarget(
        name: String,
        sdk: SDK,
        type: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return Target.target(
            name: "\(name + sdk.nameSuffix)Tests",
            destinations: sdk.destinations,
            product: .unitTests,
            bundleId: "com.cocoatype.Highlighter.\(name + sdk.nameSuffix)Tests",
            sources: ["Modules/\(type)/\(name)/Tests/**"],
            dependencies: [.target(name: name + sdk.nameSuffix)] + dependencies
        )
    }

    static func capabilitiesDoublesTarget(
        name: String,
        sdk: SDK = .catalyst
    ) -> Target {
        return Target.target(
            name: "\(name + sdk.nameSuffix)Doubles",
            destinations: sdk.destinations,
            product: .framework,
            bundleId: "com.cocoatype.Highlighter.\(name + sdk.nameSuffix)Doubles",
            sources: ["Modules/Capabilities/\(name)/Doubles/**"],
            dependencies: [
                .target(name: name + sdk.nameSuffix),
                .target(TestHelpers.interfaceTarget)
            ]
        )
    }
}
