//
//  AutoRedactionsUI.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 5/4/24.
//

import ProjectDescription

public enum AutoRedactionsUI {
    public static let target = Target.target(
        name: "AutoRedactionsUI",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.AutoRedactionsUI",
        sources: ["Modules/Capabilities/AutoRedactionsUI/Sources/**"],
        dependencies: [
            .target(ErrorHandling.target)
        ]
    )

    public static let testTarget = Target.target(
        name: "AutoRedactionsUITests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.AutoRedactionsUITests"
    )
}
