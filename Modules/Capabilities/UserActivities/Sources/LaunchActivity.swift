//  Created by Geoff Pado on 2/13/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Foundation

public class LaunchActivity: NSUserActivity {
    public init(_ fileURL: URL) {
        super.init(activityType: Self.activityType)
        userInfo = [Self.launchActivityURLKey: fileURL.absoluteString]
    }

    public convenience init?(userActivity: NSUserActivity) {
        guard userActivity.activityType == Self.activityType,
              let userInfo = userActivity.userInfo,
              let value = userInfo[Self.launchActivityURLKey] as? String,
              let url = URL(string: value)
        else { return nil }
        self.init(url)
    }

    public var representedURL: URL? {
        guard let userInfo,
              let value = userInfo[Self.launchActivityURLKey] as? String,
              let url = URL(string: value)
        else { return nil }

        return url
    }

    // MARK: Boilerplate

    public static let activityType = "com.cocoatype.Highlighter.desktop"
    static let launchActivityURLKey = "DesktopSceneDelegate.launchActivityURLKey"

}
