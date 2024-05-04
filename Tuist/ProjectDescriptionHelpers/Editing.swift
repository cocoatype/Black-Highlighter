//
//  Editing.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Editing {
    public static let target = Target.target(
        name: "Editing",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Editing",
        sources: ["Modules/Legacy/Editing/Sources/**"],
        resources: ["Modules/Legacy/Editing/Resources/**"],
        headers: .headers(public: ["Modules/Legacy/Editing/Headers/**"]),
        dependencies: [
            .target(AutoRedactionsUI.target),
            .target(ErrorHandling.target),
            .package(product: "ClippingBezier", type: .runtime),
            .package(product: "Introspect", type: .runtime)
        ]
    )

    public static let testTarget = Target.target(
        name: "EditingTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.EditingTests"
    )
}
