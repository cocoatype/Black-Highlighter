//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsContentInformationSection: View {
    private let infoDictionary: [String: Any]?
    init(infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        self.infoDictionary = infoDictionary
    }

    var body: some View {
        Section(header: SettingsSectionHeader(SettingsUIStrings.SettingsContentProvider.Section.WebURLs.header)) {
            WebURLButton(SettingsUIStrings.SettingsContentProvider.Item.new, SettingsUIStrings.SettingsContentGenerator.versionStringFormat(versionString), path: "releases")
            WebURLButton(SettingsUIStrings.SettingsContentProvider.Item.about, path: "about")
            WebURLButton(SettingsUIStrings.SettingsContentProvider.Item.privacy, path: "privacy")
            WebURLButton(SettingsUIStrings.SettingsContentProvider.Item.acknowledgements, path: "acknowledgements")
            WebURLButton(SettingsUIStrings.SettingsContentProvider.Item.contact, path: "contact")
        }
    }

    private var versionString: String {
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }
}
