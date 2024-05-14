//
//  App.swift
//  HighlighterManifests
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum App {
    public static let target = Target.target(
        name: "Highlighter",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .app,
        bundleId: "com.cocoatype.Highlighter",
        infoPlist: "App/Info.plist",
        resources: .resources([
            "App/Resources/**",
        ] + Shared.resources),
        entitlements: "App/Highlighter.entitlements",
        dependencies: [
            .package(product: "OpenSSL"),
            .target(AutomatorActions.target, condition: .when([.catalyst])),
            .target(Core.target),
        ],
        settings: .settings(
            base: [
                "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": "NO",
            ],
            debug: [
                "PROVISIONING_PROFILE_SPECIFIER": "match Development com.cocoatype.Highlighter",
                "PROVISIONING_PROFILE_SPECIFIER[sdk=macosx*]": "match Development com.cocoatype.Highlighter macos",
            ], release: [
                "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.cocoatype.Highlighter",
                "PROVISIONING_PROFILE_SPECIFIER[sdk=macosx*]": "match AppStore com.cocoatype.Highlighter macos",
            ]
        )
    )
}
