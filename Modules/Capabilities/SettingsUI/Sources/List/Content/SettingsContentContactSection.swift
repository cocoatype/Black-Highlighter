//  Created by Geoff Pado on 7/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsContentContactSection: View {
    private let infoDictionary: [String: Any]?
    init(infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        self.infoDictionary = infoDictionary
    }

    var body: some View {
        Section(header: SettingsSectionHeader(Strings.header)) {
            MailButton()
            #warning("Use SKStoreReviewController")
            WebURLButton(title: Strings.appStoreTitle, subtitle: Strings.appStoreSubtitle, imageName: "App Store", url: URL(staticString: "mailto:hello@cocoatype.com"))
            WebURLButton(title: Strings.threadsTitle, subtitle: Strings.threadsSubtitle, imageName: "Threads", url: URL(staticString: "https://threads.net/@blackhighlighterapp"))
            WebURLButton(title: Strings.twitterTitle, subtitle: Strings.twitterSubtitle, imageName: "X", url: URL(staticString: "https://x.com/BlkHighlighter"))
        }
    }

    private var versionString: String {
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }

    private typealias Strings = SettingsUIStrings.SettingsContentContactSection
}
