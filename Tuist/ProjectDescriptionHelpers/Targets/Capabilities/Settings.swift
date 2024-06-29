import ProjectDescription

public enum SettingsUI {
    public static let target = Target.capabilitiesTarget(
        name: "SettingsUI",
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(Defaults.target),
            .target(ErrorHandling.target(sdk: .catalyst)),
            .target(PurchaseMarketing.target),
            .target(Purchasing.target),
            .target(Unpurchased.target),
        ]
    )

    public static let testTarget = Target.capabilitiesTestTarget(name: "SettingsUI")
}
