//
//  Photo.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Photo {
    public static let target = Target.target(
        name: "Photo",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .appExtension,
        bundleId: "com.cocoatype.Highlighter.Photo",
        sources: ["Photo/Sources/**"],
        resources: ["Photo/Resources/**"]
    )
}
