//
//  TestHelpers.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public struct TestHelpers {
    public static let target = Target.target(
        name: "TestHelpers",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.TestHelpers"
    )
}
