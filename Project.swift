import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Highlighter",
    organizationName: "Cocoatype, LLC",
    packages: [
        .remote(url: "git@github.com:adamwulf/ClippingBezier.git", requirement: .upToNextMajor(from: "1.2.0")),
        .remote(url: "https://github.com/siteline/SwiftUI-Introspect.git", requirement: .upToNextMajor(from: "0.1.3")),
        .remote(url: "git@github.com:TelemetryDeck/SwiftClient.git", requirement: .upToNextMajor(from: "1.0.0")),
        .remote(url: "git@github.com:krzyzanowskim/OpenSSL.git", requirement: .upToNextMajor(from: "3.1.5003")),
    ],
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
        "TARGETED_DEVICE_FAMILY": "1,2,6",
    ], debug: [
        "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
    ], release: [
        "CODE_SIGN_IDENTITY": "Apple Distribution",
        "CODE_SIGN_IDENTITY[sdk=macosx*]": "3rd Party Mac Developer Installer: Cocoatype, LLC (287EDDET2B)",
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
        ErrorHandling.target,
        Logging.target,
        Observations.target,
        PurchaseMarketing.target,
        Purchasing.target,
        Receipts.target,
        Redacting.target,
        Redactions.target,
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
