//
//  Action.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Action {
    public static let target = Target.target(
        name: "Action",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .appExtension,
        bundleId: "com.cocoatype.Highlighter.Action",
        sources: ["Action/Sources/**"],
        resources: ["Action/Resources/**"]
    )
}
