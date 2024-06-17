//  Created by Geoff Pado on 6/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import DesignSystem
import SwiftUI

@available(iOS 15.0, *)
public struct OverlayPreferencesView: View {
    @Defaults.Binding(key: .showDetectedTextOverlay) private var isDetectedTextOverlayEnabled: Bool
    @Defaults.Binding(key: .showDetectedCharactersOverlay) private var isDetectedCharactersOverlayEnabled: Bool
    @Defaults.Binding(key: .showRecognizedTextOverlay) private var isRecognizedTextOverlayEnabled: Bool
    @Defaults.Binding(key: .showCalculatedOverlay) private var isCalculatedOverlayEnabled: Bool

    public var body: some View {
        List {
            PreferencesCell(isOn: $isDetectedTextOverlayEnabled, title: "Detected Text", color: .red)
            PreferencesCell(isOn: $isDetectedCharactersOverlayEnabled, title: "Detected Characters", color: .blue)
            PreferencesCell(isOn: $isRecognizedTextOverlayEnabled, title: "Recognized Text", color: .yellow)
            PreferencesCell(isOn: $isCalculatedOverlayEnabled, title: "Calculated Area", color: .green)
        }
    }

    private struct PreferencesCell: View {
        @Binding var isOn: Bool
        let title: String
        let color: Color

        var body: some View {
            Toggle(isOn: $isOn) {
                Text(title)
            }.tint(color)
        }
    }
}

@available(iOS 15.0, *)
enum OverlayPreferencesViewPreviews: PreviewProvider {
    static var previews: some View {
        OverlayPreferencesView()
    }
}
