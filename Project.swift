import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Highlighter",
    organizationName: "Cocoatype, LLC",
    settings: Shared.settings,
    targets: [
        // products
        App.target,
        Action.target,
        AutomatorActions.target,
        Photo.target,
        // modules
        AppRatings.target,
        AutoRedactionsUI.target,
        Brushes.target(sdk: .catalyst),
        Brushes.target(sdk: .native),
        Core.target,
        Defaults.target,
        DesignSystem.target,
        Detections.target(sdk: .catalyst),
        Detections.target(sdk: .native),
        Editing.target,
        ErrorHandling.target(sdk: .catalyst),
        ErrorHandling.target(sdk: .native),
        Exporting.target,
        Geometry.target(sdk: .catalyst),
        Geometry.target(sdk: .native),
        Logging.target(sdk: .catalyst),
        Logging.target(sdk: .native),
        Observations.target(sdk: .catalyst),
        Observations.target(sdk: .native),
        PurchaseMarketing.target,
        Purchasing.target,
        Redacting.target,
        Redactions.target(sdk: .catalyst),
        Redactions.target(sdk: .native),
        Shortcuts.target,
        Unpurchased.target,
        // doubles
        DesignSystem.doublesTarget,
        Logging.doublesTarget,
        Purchasing.doublesTarget,
        // test helpers
        TestHelpers.target,
        TestHelpers.interfaceTarget,
        // tests
        AppRatings.testTarget,
        AutoRedactionsUI.testTarget,
        Brushes.testTarget,
        Core.testTarget,
        Detections.testTarget,
        Editing.testTarget,
        ErrorHandling.testTarget,
        Exporting.testTarget,
        Geometry.testTarget,
        Logging.testTarget,
        Observations.testTarget,
        PurchaseMarketing.testTarget,
        Purchasing.testTarget,
        Redactions.testTarget,
        Shortcuts.testTarget,
        Unpurchased.testTarget,
    ],
    schemes: [
        .scheme(
            name: "Highlighter",
            buildAction: .buildAction(targets: [
                .target(App.target.name),
            ]),
            testAction: .testPlans([
                "Highlighter.xctestplan",
            ]),
            runAction: .runAction(
                arguments: .arguments(
                    environmentVariables: [
                        "OVERRIDE_PURCHASE": .environmentVariable(value: "", isEnabled: false),
                        "SHOW_DEBUG_OVERLAY": .environmentVariable(value: "", isEnabled: false),
                    ],
                    launchArguments: [
                    ]
                ),
                options: .options(
                    storeKitConfigurationPath: "App/Configuration.storekit"
                )
            )
        ),
    ]
)
