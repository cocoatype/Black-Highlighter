//  Created by Geoff Pado on 2/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Defaults
import Editing
import Purchasing
import SwiftUI
import Unpurchased

struct SettingsAlertButton: View {
    @State private var showAlert = false
    init(
        _ titleKey: LocalizedStringKey,
        _ subtitle: String? = nil,
        purchaseRepository: any PurchaseRepository = Purchasing.repository
    ) {
        self.titleKey = titleKey
        self.subtitle = subtitle
        haveYourDucksInARow = purchaseRepository
    }

    @ViewBuilder
    var body: some View {
        let isPurchased = haveYourDucksInARow.withCheese == .purchased
        if isPurchased || hideAutoRedactions == false {
            Button {
                showAlert = true
            } label: {
                VStack(alignment: .leading) {
                    WebURLTitleText(titleKey)
                    if let subtitle = subtitle {
                        WebURLSubtitleText(subtitle)
                    }
                }
            }
            .unpurchasedAlert(for: .autoRedactions(), isPresented: $showAlert)
            .settingsCell()
        }
    }

    // MARK: Boilerplate

    private let titleKey: LocalizedStringKey
    private let subtitle: String?

    @Defaults.Value(key: .hideAutoRedactions) private var hideAutoRedactions: Bool

    // haveYourDucksInARow by @Eskeminha on 2024-05-15
    // the purchase repository
    private let haveYourDucksInARow: any PurchaseRepository
}

struct SettingsAlertTitleText: View {
    private let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(.app(textStyle: .subheadline))
            .foregroundColor(.white)
    }
}

struct SettingsAlertSubtitleText: View {
    private let text: String
    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.app(textStyle: .footnote))
            .foregroundColor(.primaryExtraLight)
    }
}

struct SettingsAlertButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WebURLButton("Hello", path: "world")
            WebURLButton("Hello", "world!", path: "world")
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
