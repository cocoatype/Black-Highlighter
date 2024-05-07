//
//  AutomatorActions.swift
//  ProjectDescriptionHelpers
//
//  Created by Geoff Pado on 5/4/24.
//

import ProjectDescription

public enum AutomatorActions {
    public static let target = Target.target(
        name: "AutomatorActions",
        destinations: [.mac],
        product: .automatorAction,
        bundleId: "com.cocoatype.Highlighter.Automator",
        infoPlist: "Automator/Info.plist",
        sources: ["Automator/Sources/**"],
        resources: ["Automator/Resources/**"],
        dependencies: [
            .target(Redacting.target),
        ],
        settings: .settings(base: [
            "WRAPPER_EXTENSION": "action",
            "OTHER_OSAFLAGS": "-x -t 0 -c 0",
        ])
    )
}
