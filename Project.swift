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
        "DEVELOPMENT_TEAM": "287EDDET2B",
        "IPHONEOS_DEPLOYMENT_TARGET": "14.0",
        "MACOSX_DEPLOYMENT_TARGET": "11.0",
        "CODE_SIGN_STYLE": "Manual",
    ], debug: ["FOO[sdk=macosx*]": "BAR"]),
    targets: [
        App.target,
        Action.target,
        Photo.target,
        AppRatings.target,
        AutoRedactionsUI.target,
        Core.target,
        Defaults.target,
        DesignSystem.target,
        Editing.target,
        ErrorHandling.target,
        Logging.target,
        Receipts.target,
//        Redacting.target,
        TestHelpers.target,
        AppRatings.testTarget,
        Core.testTarget,
        Defaults.testTarget,
        Editing.testTarget,
        ErrorHandling.testTarget,
        Logging.testTarget,
    ]
)
