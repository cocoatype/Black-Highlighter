//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit
import UserActivities

@MainActor
public struct SceneProvider {
    public init() {}

    public func sceneConfiguration(session: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if options.userActivities.contains(where: { $0.activityType == DesktopSettingsActivity.activityType}) {
            return DesktopSettingsSceneConfiguration()
        } else if SceneDependencyWrangler().dependencies(from: session, options: options) != nil {
            return DesktopSceneConfiguration()
        } else {
            #if targetEnvironment(macCatalyst)
            return DesktopOpenSceneConfiguration()
            #else
            return MobileSceneConfiguration()
            #endif
        }
    }
}
