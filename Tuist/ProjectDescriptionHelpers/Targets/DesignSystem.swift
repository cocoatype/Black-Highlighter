//
//  DesignSystem.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 5/4/24.
//

import ProjectDescription

public enum DesignSystem {
    public static let target = Target.target(
        name: "DesignSystem",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.DesignSystem",
        sources: ["Modules/Capabilities/DesignSystem/Sources/**"],
        dependencies: [
            .target(ErrorHandling.target)
        ]
    )

    public static let testTarget = Target.target(
        name: "DesignSystemTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.DesignSystemTests"
    )
}
