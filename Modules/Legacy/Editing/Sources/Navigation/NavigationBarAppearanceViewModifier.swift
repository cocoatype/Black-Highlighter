//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem
import Introspect
import SwiftUI

struct NavigationBarAppearanceViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content).introspectNavigationController { navigationController in
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
