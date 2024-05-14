//
//  Receipts.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 3/15/24.
//

import ProjectDescription

public enum Receipts {
    public static let target = Target.capabilitiesTarget(name: "Receipts", dependencies: [
        .target(ErrorHandling.target()),
    ])
}
