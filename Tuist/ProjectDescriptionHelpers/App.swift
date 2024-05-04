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
        resources: ["App/Resources/**"],
        entitlements: "App/Highlighter.entitlements",
        dependencies: [
            .target(Core.target),
        ]
    )
}
