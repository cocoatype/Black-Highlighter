//
//  ErrorHandling.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum ErrorHandling {
    public static let target = Target.target(
        name: "ErrorHandling",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.ErrorHandling",
        sources: ["Modules/Capabilities/ErrorHandling/Sources/**"],
        dependencies: [
            .target(Logging.target),
        ]
    )

    public static let testTarget = Target.target(
        name: "ErrorHandlingTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.ErrorHandlingTests"
    )
}
