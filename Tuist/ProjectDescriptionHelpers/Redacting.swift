//
//  Redacting.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public struct Redacting {
    public static let target = Target.target(
        name: "Redacting",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Redacting"
    )
}
