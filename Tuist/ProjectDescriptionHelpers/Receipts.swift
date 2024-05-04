//
//  Receipts.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Receipts {
    public static let target = Target.target(
        name: "Receipts",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Receipts",
        sources: ["Modules/Legacy/Receipts/Sources/**"],
        dependencies: [
            .package(product: "OpenSSL"),
            .target(ErrorHandling.target),
        ]
    )
}
