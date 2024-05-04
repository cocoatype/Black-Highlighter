//
//  AppRatings.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum AppRatings {
    public static let target = Target.target(
        name: "AppRatings",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.AppRatings",
        sources: ["Modules/Capabilities/AppRatings/Sources/**"],
        dependencies: [
            .target(ErrorHandling.target)
        ]
    )

    public static let testTarget = Target.target(
        name: "AppRatingsTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.AppRatingsTests"
    )
}
