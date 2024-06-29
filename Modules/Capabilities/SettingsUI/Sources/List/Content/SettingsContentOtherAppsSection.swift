//  Created by Geoff Pado on 6/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsContentOtherAppsSection: View {
    var body: some View {
        Section(header: SettingsSectionHeader("SettingsContentProvider.Section.otherApps.header")) {
            OtherAppButton(name: "Kineo", subtitle: "Draw flipbook-style animations", id: "286948844")
            OtherAppButton(name: "Scrawl", subtitle: "definitely an app", id: "1229326968")
            OtherAppButton(name: "Debigulator", subtitle: "Shrink images to send faster", id: "1510076117")
        }
    }
}
