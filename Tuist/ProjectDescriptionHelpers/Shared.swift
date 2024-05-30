import ProjectDescription

public enum Shared {
    static let resources: [ResourceFileElement] = [
        "App/Resources/Assets.xcassets",
    ]

    public static let settings: Settings = .settings(base: [
        "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "Accent Color",
        "CODE_SIGN_STYLE": "Manual",
        "CURRENT_PROJECT_VERSION": "0",
        "DEVELOPMENT_TEAM": "287EDDET2B",
        "ENABLE_HARDENED_RUNTIME[sdk=macosx*]": "YES",
        "IPHONEOS_DEPLOYMENT_TARGET": "14.0",
        "MACOSX_DEPLOYMENT_TARGET": "12.0",
        "MARKETING_VERSION": "999",
        "OTHER_CODE_SIGN_FLAGS": "--deep",
        "SWIFT_VERSION": "5.0",
        "TARGETED_DEVICE_FAMILY": "1,2,6",
    ], debug: [
        "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
    ], release: [
        "CODE_SIGN_IDENTITY": "Apple Distribution",
    ])
}
