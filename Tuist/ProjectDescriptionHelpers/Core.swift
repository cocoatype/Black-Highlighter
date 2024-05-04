//
//  Core.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Core {
    public static let target = Target.target(
        name: "Core",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Core",
        sources: ["Modules/Legacy/Core/Sources/**"],
        dependencies: [
            .target(AppRatings.target),
            .target(AutoRedactionsUI.target),
            .target(Defaults.target),
            .target(DesignSystem.target),
            .target(Editing.target),
            .target(Receipts.target),
        ]
    )

    public static let testTarget = Target.target(
        name: "CoreTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.CoreTests"
    )
}
