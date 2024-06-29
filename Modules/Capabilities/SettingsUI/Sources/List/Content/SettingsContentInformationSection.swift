//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsContentInformationSection: View {
    private let infoDictionary: [String: Any]?
    init(infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        self.infoDictionary = infoDictionary
    }

    var body: some View {
        Section(header: SettingsSectionHeader("SettingsContentProvider.Section.webURLs.header")) {
            WebURLButton("SettingsContentProvider.Item.new", SettingsUIStrings.SettingsContentGenerator.versionStringFormat(versionString), path: "releases")
            WebURLButton("SettingsContentProvider.Item.about", path: "about")
            WebURLButton("SettingsContentProvider.Item.privacy", path: "privacy")
            WebURLButton("SettingsContentProvider.Item.acknowledgements", path: "acknowledgements")
            WebURLButton("SettingsContentProvider.Item.contact", path: "contact")
        }
    }

    private var versionString: String {
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }
}
