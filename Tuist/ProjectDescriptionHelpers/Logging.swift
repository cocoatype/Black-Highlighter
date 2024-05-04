//
//  Logging.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Logging {
    public static let target = Target.target(
        name: "Logging",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Logging",
        sources: ["Modules/Capabilities/Logging/Sources/**"],
        dependencies: [
            .package(product: "TelemetryClient", type: .runtime),
        ]
    )

    public static let testTarget = Target.target(
        name: "LoggingTests",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .unitTests,
        bundleId: "com.cocoatype.Highlighter.LoggingTests"
    )
}
