//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

#if targetEnvironment(macCatalyst)
class DesktopOpenSceneDelegate: NSObject, UIWindowSceneDelegate, UIDocumentBrowserViewControllerDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = DesktopOpenWindow(windowScene: scene)
        window.makeKeyAndVisible()

        self.window = window
    }

    private let urlHandler = DesktopSceneURLHandler()
    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        let results = urlContexts.map(urlHandler.handle(_:))
        if results.contains(where: { $0 }) {
            UIApplication.shared.requestSceneSessionDestruction(scene.session, options: nil)
        }
    }
}
#endif
