//
//  Photo.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Photo {
    public static let target = Target.target(
        name: "Photo",
        destinations: [.iPhone, .iPad, .appleVisionWithiPadDesign],
        product: .appExtension,
        bundleId: "com.cocoatype.Highlighter.Photo",
        infoPlist: "Photo/Info.plist",
        sources: ["Photo/Sources/**"],
        resources: .resources([
            "Photo/Resources/**",
        ] + Shared.resources),
        settings: .settings(
            base: [
                "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
                "SKIP_INSTALL": "YES",
            ],
            debug: [
                "PROVISIONING_PROFILE_SPECIFIER": "match Development com.cocoatype.Highlighter.Photo",
            ],
            release: [
                "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.cocoatype.Highlighter.Photo",
            ],
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
            ])
        )
    )
}
