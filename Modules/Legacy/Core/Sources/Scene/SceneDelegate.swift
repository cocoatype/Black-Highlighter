//  Created by Geoff Pado on 7/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit
import URLParsing

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: AppWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = AppWindow(scene: scene)
        window.makeKeyAndVisible()
        self.window = window

        guard handle(connectionOptions.urlContexts) else {
            let restorationActivity = session.stateRestorationActivity
            let dragActivity = connectionOptions.userActivities.first

            if let userActivity = restorationActivity ?? dragActivity {
                window.restore(from: userActivity)
            }

            return
        }
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        window?.stateRestorationActivity
    }

    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        handle(urlContexts)
    }

    @discardableResult
    private func handle(_ urlContexts: Set<UIOpenURLContext>) -> Bool {
        guard let url = urlContexts.first?.url else { return false }
        return switch URLParser().parse(url) {
        case .callbackAction(let action):
            handleCallbackAction(action)
        case .image(let image):
            open(image)
        case .website(let webURL):
            open(webURL)
        case .invalid:
            false
        }
    }

    private func handleCallbackAction(_ action: CallbackAction) -> Bool {
        guard let appViewController else { return false }
        switch action {
        case .open(let image):
            appViewController.presentPhotoEditingViewController(for: image, animated: false)
        case .edit(let image, let successURL):
            appViewController.presentPhotoEditingViewController(for: image, animated: false) { editedImage in
                guard let successURL = successURL,
                  var callbackURLComponents = URLComponents(url: successURL, resolvingAgainstBaseURL: true),
                  let imageData = editedImage.pngData(),
                  let imageEncodedString = imageData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else { return }

                callbackURLComponents.queryItems = [URLQueryItem(name: "imageData", value: imageEncodedString)]

                guard let callbackURL = callbackURLComponents.url else { return }
                UIApplication.shared.open(callbackURL)
            }
        }

        return true
    }

    private func open(_ image: UIImage) -> Bool {
        guard let appViewController else { return false }

        appViewController.presentPhotoEditingViewController(for: image, animated: false)
        return true
    }

    private func open(_ webURL: URL) -> Bool {
        guard let appViewController else { return false }
        appViewController.presentWebView(for: webURL)
        return true
    }

    private var appViewController: AppViewController? { return window?.rootViewController as? AppViewController }
}
