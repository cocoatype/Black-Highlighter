// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    productTypes: [
        "TelemetryClient": .framework,
    ],
    baseSettings: Shared.settings,
    targetSettings: [
        "TelemetryClient": [
            "UNINSTALLED_PRODUCTS_DIR": "$(TEMP_ROOT)/UninstalledProducts$(EFFECTIVE_PLATFORM_NAME)",
        ],
    ]
)
#endif

let package = Package(
    name: "Dependencies",
    dependencies: [
        .package(url: "git@github.com:adamwulf/ClippingBezier.git", from: "1.2.0"),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", from: "0.1.3"),
        .package(url: "git@github.com:TelemetryDeck/SwiftClient.git", from: "1.0.0"),
        .package(url: "git@github.com:nalexn/ViewInspector.git", from: "0.9.11"),
    ]
)
