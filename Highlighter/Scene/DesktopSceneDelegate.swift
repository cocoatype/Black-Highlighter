//  Created by Geoff Pado on 8/3/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Editing
import UIKit

#if targetEnvironment(macCatalyst)
class DesktopSceneDelegate: NSObject, UIWindowSceneDelegate, NSToolbarDelegate, ShareItemDelegate, ToolPickerItemDelegate, ColorPickerItemDelegate, SeekItemDelegate {
    var window: DesktopAppWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let representedURL: URL?
        let redactions: [Redaction]?
        if let stateRestorationActivity = session.stateRestorationActivity, let activity = EditingUserActivity(userActivity: stateRestorationActivity) {
            representedURL = self.representedURL(from: activity)
            redactions = activity.redactions
        } else {
            representedURL = self.representedURL(from: connectionOptions)
            redactions = nil
        }

        let window = DesktopAppWindow(windowScene: scene, representedURL: representedURL, redactions: redactions)
        window.makeKeyAndVisible()

        let toolbar = NSToolbar()
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly
        scene.titlebar?.toolbar = toolbar
        scene.titlebar?.toolbarStyle = .unified

        self.window = window
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        window?.stateRestorationActivity
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        var contexts = URLContexts
        if let windowScene = scene as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController,
           let desktopViewController = rootViewController as? DesktopViewController,
           desktopViewController.representedURL == nil,
           let context = contexts.popFirst() {
            desktopViewController.representedURL = context.url
        }
        Self.activateSessions(for: contexts)
    }

    static func activateSessions(for urlContexts: Set<UIOpenURLContext>) {
        urlContexts.forEach { context in
            let activity = LaunchActivity(context.url)
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
        }
    }

    func validateToolbarItems() {
        window?.windowScene?.titlebar?.toolbar?.visibleItems?.forEach { $0.validate() }
    }

    private func representedURL(from options: UIScene.ConnectionOptions) -> URL? {
        var urlContexts = options.urlContexts
        if let urlContext = urlContexts.popFirst() {
            Self.activateSessions(for: urlContexts) // create new sessions for any others
            return urlContext.url
        } else if let urlActivity = options.userActivities.first(where: { $0.activityType == LaunchActivity.activityType }) {
            guard let userInfo = urlActivity.userInfo,
                  let value = userInfo[LaunchActivity.launchActivityURLKey],
                  let urlString = value as? String,
                  let url = URL(string: urlString)
            else { return nil }
            return url
        }

        return nil
    }

    private func representedURL(from activity: EditingUserActivity) -> URL? {
        var isStale = false
        guard let bookmarkData = activity.imageBookmarkData,
              let url = try? URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale),
              FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return url
    }

    // MARK: ShareItemDelegate

    var canExportImage: Bool { return editingViewController != nil }

    func exportImage(_ completionHandler: @escaping ((UIImage?) -> Void)) {
        editingViewController?.exportImage(completionHandler: completionHandler)
    }

    func didExportImage() {
        Defaults.numberOfSaves = Defaults.numberOfSaves + 1
        DispatchQueue.main.async { [weak self] in
            AppRatingsPrompter.displayRatingsPrompt(in: self?.window?.windowScene)
        }
    }

    // MARK: ToolPickerItemDelegate

    var highlighterTool: HighlighterTool { return editingViewController?.highlighterTool ?? .magic }

    // MARK: ColorPickerItemDelegate

    var currentColor: UIColor { return .black }

    @objc func displayColorPicker(_ sender: NSToolbarItem) {
        editingViewController?.showColorPicker(self)
    }

    // MARK: SeekItemDelegate

    func startSeeking(_ sender: NSToolbarItem) {
        editingViewController?.startSeeking(sender)
    }

    // MARK: NSToolbarDelegate

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        var identifiers = [NSToolbarItem.Identifier]()
        if FeatureFlag.seekAndDestroy {
            identifiers.append(SeekItem.identifier)
        }

        identifiers.append(contentsOf: [ColorPickerItem.identifier, ToolPickerItem.identifier, ShareItem.identifier])
        return identifiers
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case ToolPickerItem.identifier: return ToolPickerItem(delegate: self)
        case ShareItem.identifier: return ShareItem(delegate: self)
        case ColorPickerItem.identifier: return ColorPickerItem(delegate: self)
        case SeekItem.identifier: return SeekItem(delegate: self)
        default: return nil
        }
    }

    // MARK: Boilerplate

    private var desktopViewController: DesktopViewController? { window?.rootViewController as? DesktopViewController }
    private var editingViewController: PhotoEditingViewController? { desktopViewController?.editingViewController }
}
#endif
