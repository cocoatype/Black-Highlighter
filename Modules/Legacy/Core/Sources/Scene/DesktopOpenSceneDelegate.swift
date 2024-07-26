//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit
import UserActivities

#if targetEnvironment(macCatalyst)
class DesktopOpenSceneDelegate: NSObject, UIWindowSceneDelegate, UIDocumentBrowserViewControllerDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        let browserViewController = DesktopDocumentBrowserViewController()
        browserViewController.delegate = self
        window.isOpaque = false
        window.rootViewController = browserViewController
        window.makeKeyAndVisible()

        self.window = window
    }

    private let urlHandler = DesktopSceneURLHandler()
    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        let results = urlContexts.map(urlHandler.handle(_:))
        if results.contains(where: \.self) {
            UIApplication.shared.requestSceneSessionDestruction(scene.session, options: nil)
        }
    }

    // MARK: Document Browser Delegate

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let documentURL = documentURLs.first else { return }
        let activity = LaunchActivity(documentURL)
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
    }
}
#endif
