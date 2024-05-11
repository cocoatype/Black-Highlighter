//  Created by Geoff Pado on 5/11/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import SwiftUI

public struct UnpurchasedAlertViewModifier: ViewModifier {
    @Binding private var isPresented: Bool
    private let feature: UnpurchasedFeature
    init(for feature: UnpurchasedFeature, isPresented: Binding<Bool>) {
        _isPresented = isPresented
        self.feature = feature
    }

    public func body(content: Content) -> some View {
        content.alert(isPresented: $isPresented) {
            if let hideFeatureKey = feature.hideFeatureKey {
                @Defaults.Value(key: hideFeatureKey) var hideFeature: Bool
                return Alert(
                    title: Text(Strings.title),
                    message: Text(feature.message),
                    primaryButton: .cancel(Text(Strings.dismissButton)),
                    secondaryButton: .default(Text(Strings.hideButton)) {
                        hideFeature = true
                    }
                )
            } else {
                return Alert(
                    title: Text(Strings.title),
                    message: Text(feature.message),
                    dismissButton: .cancel(Text(Strings.dismissButton))
                )
            }
        }
    }

    private typealias Strings = UnpurchasedStrings.UnpurchasedAlert
}

public extension View {
    func unpurchasedAlert(for feature: UnpurchasedFeature, isPresented: Binding<Bool>) -> ModifiedContent<Self, UnpurchasedAlertViewModifier> {
        modifier(UnpurchasedAlertViewModifier(for: feature, isPresented: isPresented))
    }
}
