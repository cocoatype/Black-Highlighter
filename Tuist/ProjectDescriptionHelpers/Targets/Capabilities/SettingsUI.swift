import ProjectDescription

public enum SettingsUI {
    public static let target = Target.capabilitiesTarget(
        name: "SettingsUI",
        hasResources: true,
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(Defaults.target),
            .target(ErrorHandling.target(sdk: .catalyst)),
            .target(PurchaseMarketing.target),
            .target(Purchasing.target),
            .target(Unpurchased.target),
            .external(name: "SwiftUIIntrospect-Dynamic"),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(
        name: "SettingsUI",
        dependencies: [
            .external(name: "ViewInspector"),
        ]
    )
}
