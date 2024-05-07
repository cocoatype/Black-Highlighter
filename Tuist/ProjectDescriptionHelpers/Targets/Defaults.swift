//
//  Defaults.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Defaults {
    public static let target = Target.target(
        name: "Defaults",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Defaults",
        sources: ["Modules/Capabilities/Defaults/Sources/**"]
    )

    public static let testTarget = Target.target(
        name: "DefaultsTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.DefaultsTests"
    )
}
