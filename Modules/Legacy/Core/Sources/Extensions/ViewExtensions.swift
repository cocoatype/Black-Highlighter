//  Created by Geoff Pado on 5/30/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import SwiftUI

extension View {
    public func continuousCornerRadius(_ radius: CGFloat) -> some View {
        return self.modifier(ContinuousCornerRadiusViewModifier(radius))
    }
}

struct ContinuousCornerRadiusViewModifier: ViewModifier {
    private let radius: CGFloat
    init(_ radius: CGFloat) {
        self.radius = radius
    }

    func body(content: Content) -> some View {
        AnyView(content).clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}
