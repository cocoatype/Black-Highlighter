//  Created by Geoff Pado on 5/19/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsListStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content).listStyle(InsetGroupedListStyle())
    }
}

extension View {
    func settingsListStyle() -> ModifiedContent<Self, SettingsListStyleModifier> {
        modifier(SettingsListStyleModifier())
    }
}
