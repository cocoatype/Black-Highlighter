//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import SwiftUIIntrospect

struct NavigationBarAppearanceViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
            .introspect(.navigationView(style: .stack), on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { navigationController in
                navigationController.navigationBar.standardAppearance = NavigationBarAppearance()
                navigationController.navigationBar.scrollEdgeAppearance = NavigationBarAppearance()

                navigationController.navigationBar.tintColor = .white
                navigationController.navigationBar.prefersLargeTitles = false
            }
    }
}

public extension View {
    func appNavigationBarAppearance() -> some View {
        self.modifier(NavigationBarAppearanceViewModifier())
    }
}
