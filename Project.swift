import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Highlighter",
    organizationName: "Cocoatype, LLC",
    settings: .settings(base: [
        "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
        "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "Accent Color",
        "CODE_SIGN_STYLE": "Manual",
        "CURRENT_PROJECT_VERSION": "0",
        "DEVELOPMENT_TEAM": "287EDDET2B",
        "ENABLE_HARDENED_RUNTIME[sdk=macosx*]": "YES",
        "IPHONEOS_DEPLOYMENT_TARGET": "15.0",
        "MACOSX_DEPLOYMENT_TARGET": "12.0",
        "MARKETING_VERSION": "999",
        "OTHER_CODE_SIGN_FLAGS": "--deep",
        "SWIFT_VERSION": "5.0",
        "TARGETED_DEVICE_FAMILY": "1,2,6",
    ], debug: [
        "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
    ], release: [
        "CODE_SIGN_IDENTITY": "Apple Distribution",
    ]),
    targets: [
        // products
        App.target,
        Action.target,
        AutomatorActions.target,
        Photo.target,
        // modules
        AppRatings.target,
        AutoRedactionsUI.target,
        Core.target,
        Defaults.target,
        DesignSystem.target,
        Editing.target,
        ErrorHandling.target(sdk: .catalyst),
        ErrorHandling.target(sdk: .native),
        Logging.target(sdk: .catalyst),
        Logging.target(sdk: .native),
        Observations.target(sdk: .catalyst),
        Observations.target(sdk: .native),
        PurchaseMarketing.target,
        Purchasing.target,
        Redacting.target,
        Redactions.target(sdk: .catalyst),
        Redactions.target(sdk: .native),
        Unpurchased.target,
        // doubles
        Logging.doublesTarget,
        Purchasing.doublesTarget,
        // test helpers
        TestHelpers.target,
        TestHelpers.interfaceTarget,
        // tests
        AppRatings.testTarget,
        AutoRedactionsUI.testTarget,
        Core.testTarget,
        Editing.testTarget,
        ErrorHandling.testTarget,
        Logging.testTarget,
        Observations.testTarget,
        PurchaseMarketing.testTarget,
        Purchasing.testTarget,
        Redactions.testTarget,
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
                        .launchArgument(name: "-FeatureFlag.autoRedactInEdit YES", isEnabled: false),
                    ]
                )
            )
        ),
    ]
)
